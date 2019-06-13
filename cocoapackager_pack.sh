#!/bin/bash
TARGET="HelloWorld"
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$INFOPLIST_FILE")
SPEC_SOURCES="https://github.com/hello-david/Binarization.git"
OUTPUT_FLODER="${PROJECT_DIR}/../RelaseFameworks"
PACKAGER_OUTPUT_FLODER="${PROJECT_DIR}/../${TARGET}-${BUILD_NUMBER}"

#使用cocoa package打包
cd ${SRCROOT}
pod _1.5.3_ package --spec-sources="${SPEC_SOURCES}" "../${TARGET}.podspec" --verbose --dynamic

#拷贝framework到输出目录上
cp -R "${PACKAGER_OUTPUT_FLODER}/ios/${TARGET}.framework" ${OUTPUT_FLODER}

#删除Build目录
rm -rf ${PACKAGER_OUTPUT_FLODER}
