#!/bin/bash

LIB_DIR=~/workspace/lib/locationlabs_jars

# Clear current jars in lib directory
if [ ! -d "$LIB_DIR" ]; then
    mkdir -p $LIB_DIR
else
    rm $LIB_DIR/*
fi

find /opt/wm/apache-tomcat-7.0.11 -name '*.jar' -exec cp {} $LIB_DIR \;