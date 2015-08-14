#!/usr/bin/env bash

# PROJECT_DIRS=`find ./* -maxdepth 0 -type d`

PROJECT_DIRS='ios_utils
ios_data_model
ios_network
ios_manager
ios_sblink
ios_ui_cni
ios_cni_att
ios_cni_vzw'

for pro in $PROJECT_DIRS; do
    echo "### processing project: ${pro} ###"
    cd $pro
    rm -rf DerivedData Pods doc
    git pull
    git submodule update
    pod update
    cd ..
done
