#!/bin/bash

ARCHIVE_ROOT_DIR="${WORKSPACE}/build/${ARCHIVE_SCHEME}"
PRODUCT_NAME="Smart Limits"
LL_XCARCHIVE_NAME="${XCARCHIVE_NAME}"
LL_XCARCHIVE_PATH="${ARCHIVE_ROOT_DIR}/${LL_XCARCHIVE_NAME}"
CARRIER_XCARCHIVE_NAME=SmartLimits.xcarchive
CARRIER_XCARCHIVE_PATH="${ARCHIVE_ROOT_DIR}/${CARRIER_XCARCHIVE_NAME}"
LL_BUNDLE_ID=com.locationlabs.CniAtt
LL_BUNDLE_ID_PREFIX=MF67DWNU8J
CARRIER_BUNDLE_ID=com.locationlabs.TestResign
CARRIER_BUNDLE_ID_PREFIX=MF67DWNU8J
SIGNING_IDENTITY=A832FF7123F7558FFED64A272CAAB8E5304C295C
PROVISIONING_PROFILE=./TestResignAdHoc.mobileprovision

# Copy LL signed xcarchive
cp -r "${LL_XCARCHIVE_NAME}" "${CARRIER_XCARCHIVE_PATH}"

# Update bundle id in top level Info.plist
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "${CARRIER_XCARCHIVE_PATH}/Info.plist"

# Update bundle id in debug symbol Info.plist, need to convert from/to binary when replacing bundle id
plutil -convert xml1 "${CARRIER_XCARCHIVE_PATH}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "${CARRIER_XCARCHIVE_PATH}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"
plutil -convert binary1 "${CARRIER_XCARCHIVE_PATH}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"

# Update bundle id in app bundle Info.plist, need to convert from/to binary when replacing bundle id
plutil -convert xml1 "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"
plutil -convert binary1 "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"

# Update bundle id in entitlements.xcent
sed -i "s/${LL_BUNDLE_ID_PREFIX}.${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID_PREFIX}.${CARRIER_BUNDLE_ID}/g" "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/archived-expanded-entitlements.xcent"

# Remove current signature and provisioning profile
rm -rf "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/_CodeSignature"
rm "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Copy new provisioning profile, has to be done by carrier if their provisioning profile is not provided
cp "${PROVISIONING_PROFILE}" "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Resign with different provisioning profile, has to be done by carrier if their signing key is not provided
/usr/bin/codesign --force --sign "${SIGNING_IDENTITY}" \
                  --resource-rules="${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/ResourceRules.plist" \
                  --entitlements "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app/archived-expanded-entitlements.xcent" \
                  "${CARRIER_XCARCHIVE_PATH}/Products/Applications/${PRODUCT_NAME}.app"

# Zip it up
zip -r "${CARRIER_XCARCHIVE_PATH}.zip" "${CARRIER_XCARCHIVE_PATH}"
