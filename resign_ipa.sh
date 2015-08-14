#!/bin/bash

IPA_NAME=com.tencent.xin_5.4.1
ARCHIVE_ROOT_DIR=/Users/zhou/Downloads
PRODUCT_NAME=MicroMessenger
LL_XCARCHIVE_NAME=${XCARCHIVE_NAME}
LL_XCARCHIVE_PATH=${ARCHIVE_ROOT_DIR}/${LL_XCARCHIVE_NAME}
CARRIER_XCARCHIVE_NAME=${ARCHIVE_NAME}-${VERSION}_vzwExtDev.xcarchive
CARRIER_XCARCHIVE_PATH=${ARCHIVE_ROOT_DIR}/${CARRIER_XCARCHIVE_NAME}
LL_IPA_NAME=${IPA_NAME}.ipa
LL_IPA_PATH=${ARCHIVE_ROOT_DIR}/${LL_IPA_NAME}
LL_IPA_PAYLOAD_PATH=${ARCHIVE_ROOT_DIR}/Payload
CARRIER_IPA_NAME=${ARCHIVE_NAME}-${VERSION}_vzwExtDev.ipa
CARRIER_IPA_PATH=${ARCHIVE_ROOT_DIR}/${CARRIER_IPA_NAME}
LL_BUNDLE_ID=com.locationlabs.CniVzw
LL_BUNDLE_ID_PREFIX=MF67DWNU8J
CARRIER_BUNDLE_ID=com.vzw.familybase
CARRIER_BUNDLE_ID_PREFIX= FCMA4QKS77
SIGNING_IDENTITY=09480D8A13B6DFCC859B694C0BDA0B0985BD9974
PROVISIONING_PROFILE=${WORKSPACE}/ios_keystore/cni/vzw/ExternalDevProfileWildcard/ExternalDevWildcard.mobileprovision

# Unzip ipa
unzip "${LL_IPA_PATH}" -d "${ARCHIVE_ROOT_DIR}"

# Update bundle id in app bundle Info.plist, need to convert from/to binary when replacing bundle id
plutil -convert xml1 "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/Info.plist"
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/Info.plist"
plutil -convert binary1 "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/Info.plist"

# Remove current signature and provisioning profile
rm -rf "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/_CodeSignature"
rm "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Copy new provisioning profile
cp "${PROVISIONING_PROFILE}" "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Resign with different provisioning profile
/usr/bin/codesign --force --sign "${SIGNING_IDENTITY}" \
                  --resource-rules="${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app/ResourceRules.plist" \
                  --entitlements "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/archived-expanded-entitlements.xcent" \
                  "${LL_IPA_PAYLOAD_PATH}/${PRODUCT_NAME}.app"

# Zip it up again
cd "${ARCHIVE_ROOT_DIR}"
zip -r "${CARRIER_IPA_NAME}" Payload
