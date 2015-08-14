#!/bin/bash

PRODUCT_NAME="Smart Limits"
LL_XCARCHIVE_NAME=SmartLimits-ExtStable_Release-1.0-2014-09-13_11-27-22_13.xcarchive
LL_XCARCHIVE_PATH="./${LL_XCARCHIVE_NAME}"
XCARCHIVE_NAME=SmartLimits.xcarchive
XCARCHIVE_PATH="./${XCARCHIVE_NAME}"
LL_BUNDLE_ID=com.locationlabs.CniAtt
LL_BUNDLE_ID_PREFIX=MF67DWNU8J
CARRIER_BUNDLE_ID=com.locationlabs.TestResign
CARRIER_BUNDLE_ID_PREFIX=MF67DWNU8J
SIGNING_IDENTITY=A832FF7123F7558FFED64A272CAAB8E5304C295C
PROVISIONING_PROFILE=./TestResignAdHoc.mobileprovision

# Copy LL signed xcarchive
cp -r "${LL_XCARCHIVE_NAME}" "${XCARCHIVE_PATH}"

# Update bundle id in top level Info.plist
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" ./${XCARCHIVE_NAME}/Info.plist

# Update bundle id in debug symbol Info.plist, need to convert from/to binary when replacing bundle id
plutil -convert xml1 "./${XCARCHIVE_NAME}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "./${XCARCHIVE_NAME}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"
plutil -convert binary1 "./${XCARCHIVE_NAME}/dSYMs/${PRODUCT_NAME}.app.dSYM/Contents/Info.plist"

# Update bundle id in app bundle Info.plist, need to convert from/to binary when replacing bundle id
plutil -convert xml1 "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"
sed -i "s/${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID}/g" "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"
plutil -convert binary1 "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/Info.plist"

# Update bundle id in entitlements.xcent
sed -i "s/${LL_BUNDLE_ID_PREFIX}.${LL_BUNDLE_ID}/${CARRIER_BUNDLE_ID_PREFIX}.${CARRIER_BUNDLE_ID}/g" "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/archived-expanded-entitlements.xcent"

# Remove current signature and provisioning profile
rm -rf "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/_CodeSignature"
rm "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Copy new provisioning profile, has to be done by carrier if their provisioning profile is not provided
cp "${PROVISIONING_PROFILE}" "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/embedded.mobileprovision"

# Resign with different provisioning profile, has to be done by carrier if their signing key is not provided
/usr/bin/codesign --force --sign "${SIGNING_IDENTITY}" \
                  --resource-rules="./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/ResourceRules.plist" \
                  --entitlements "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app/archived-expanded-entitlements.xcent" \
                  "./${XCARCHIVE_NAME}/Products/Applications/${PRODUCT_NAME}.app"

# Zip it up
zip -r "${XCARCHIVE_PATH}.zip" "${XCARCHIVE_PATH}"
