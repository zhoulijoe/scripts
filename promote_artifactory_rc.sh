#!/bin/bash

if [ $# -lt 4 ]; then
    echo -e "usage:$0 [PASSWORD] [PROJECT] [VERSION] [RC_NUM]"
    exit 1
fi

USER=zhou
PASSWORD=$1

PROJECT=$2
VERSION=$3
RC_NUM=$4

# Move specified RC build to release dir
curl -X POST -u $USER:$PASSWORD "http://artifactory.engr.wavemarket.com/api/copy/ios-rc/com/locationlabs/$PROJECT/$VERSION/$RC_NUM?to=/ios-release/com/locationlabs/$PROJECT/$VERSION"
