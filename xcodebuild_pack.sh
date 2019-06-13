#!/bin/sh

TARGET="HelloWorld"

#如果有输入参数则用输入参数
if [[ $1 ]]
then
TARGET=$1
fi

#定义一下用到的变量,接下去不使用外部环境变量
OUTPUT_FLODER="${PROJECT_DIR}/../ReleaseFameworks"
PROJECT="${PODS_ROOT}/Pods.xcodeproj"
BUILD_DIR="${BUILD_DIR}"
BUILD_ROOT="${BUILD_ROOT}"
CONFIGURATION="Release"
BUILD_IPHONEOS_FRAMEWORK_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${TARGET}/${TARGET}.framework" 
BUILD_IPHONESIMULATOR_FRAMEWORK_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET}/${TARGET}.framework"

#创建输出目录，并删除之前的framework文件
mkdir -p "${OUTPUT_FLODER}"
rm -rf "${OUTPUT_FLODER}/${TARGET}.framework"

#分别编译模拟器和真机的Framework，同时不使用new build system
xcodebuild -project ${PROJECT} -target "${TARGET}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -UseModernBuildSystem=NO
xcodebuild -project ${PROJECT} -target "${TARGET}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -UseModernBuildSystem=NO

#拷贝framework到输出目录上
cp -R ${BUILD_IPHONEOS_FRAMEWORK_PATH} ${OUTPUT_FLODER}

#合并framework，输出最终的framework到build目录
lipo -create -output "${OUTPUT_FLODER}/${TARGET}.framework/${TARGET}" "${BUILD_IPHONESIMULATOR_FRAMEWORK_PATH}/${TARGET}" "${BUILD_IPHONEOS_FRAMEWORK_PATH}/${TARGET}"

#删除编译之后生成的无关的配置文件
dir_path="${OUTPUT_FLODER}/${TARGET}.framework/"
for file in ls $dir_path
do
if [[ ${file} =~ ".xcconfig" ]]
then
rm -f "${dir_path}/${file}"
fi
done

#判断build文件夹是否存在，存在则删除
if [ -d "${SRCROOT}/build" ]
then
rm -rf "${SRCROOT}/build"
fi
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator" "${BUILD_DIR}/${CONFIGURATION}-iphoneos"
