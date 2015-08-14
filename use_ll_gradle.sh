#!/bin/bash

LL_WORKSPACE="~/workspace/ll"
GRADLE_COMMON_DIR="${LL_WORKSPACE}/build_deploy/build_tools/gradle_common"

LL_GRADLE=1

while getopts n OPTION; do
     case $OPTION in
         n)
             LL_GRADLE=0
             ;;
     esac
done

echo $LL_GRADLE

if [ $LL_GRADLE -eq 1 ]; then
    export GRADLE_COMMON="${GRADLE_COMMON_DIR}"
    export GRADLE_OPTS="-Dorg.gradle.daemon=true"

    if [ ! -e ~/.gradle/init.d ] || [ -h ~/.gradle/init.d ]; then
        rm -f ~/.gradle/init.d
        ln -s ${GRADLE_COMMON_DIR}/init.d ~/.gradle/init.d
    fi
else
    export GRADLE_COMMON=""
    export GRADLE_OPTS=""

    rm -f ~/.gradle/init.d
fi
