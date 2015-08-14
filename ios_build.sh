#!/bin/bash

WORKSPACE_NAME=CniAtt
ARCHIVE_SCHEME=Production_Release
BUILD_ROOT_DIR=/Users/zhou/build/aci/${ARCHIVE_SCHEME}
PRODUCT_NAME="Smart Limits"
ARCHIVE_NAME=SmartLimits
IPA_NAME=${ARCHIVE_NAME}
LL_IPA_NAME=${IPA_NAME}.ipa
LL_IPA_PATH=${BUILD_ROOT_DIR}/${LL_IPA_NAME}
SIGNING_IDENTITY="iPhone Distribution: Project Management (MF67DWNU8J)"

/usr/bin/xcodebuild -scheme ${ARCHIVE_SCHEME} \
                    -workspace ${WORKSPACE_NAME}.xcworkspace \
                    -sdk iphoneos \
                    build \
                    CONFIGURATION_BUILD_DIR=${BUILD_ROOT_DIR}

/usr/bin/xcrun -sdk iphoneos \
               PackageApplication -v "${BUILD_ROOT_DIR}/${PRODUCT_NAME}.app" \
               -o ${LL_IPA_PATH} \
               --sign "${SIGNING_IDENTITY}"
