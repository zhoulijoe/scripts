#!/usr/bin/env bash

#PROJECT_DIRS=`find ./* -maxdepth 0 -type d`

PROJECT_DIRS='ios_utils
ios_data_model
ios_network
ios_manager
ios_ui_cni'

for pro in $PROJECT_DIRS; do
    echo "### processing project: ${pro} ###"
    cd $pro
    
    # Make a commit
    # git commit -a -m $'Locking down AFNetworking version'
    # git push

    # Change submodule commit
    # cd lib/build
    # git fetch --all
    # git checkout e12705fa9bcf4be9effde395ec736003e34d5bfa
    # cd ../..

    # Create a tag
    git push origin :1.0.0
    git tag -d 1.0.0
    git tag -a 1.0.0 -m "Release 1.0.0, used by release 1.0 of ACI and VCI app"
    git push origin 1.0.0
    
    cd ..
done
