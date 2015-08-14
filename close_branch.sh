#!/usr/bin/env bash

BRANCH_NAME=$1

#PROJECT_DIRS=`find ./* -maxdepth 0 -type d`

PROJECT_DIRS='ios_utils
ios_data_model
ios_network
ios_manager
ios_ui_cni
ios_cni_att
ios_cni_vzw'

for pro in $PROJECT_DIRS; do
    echo "### processing project: ${pro} ###"
    cd $pro

    git show-ref --verify --quiet "refs/remotes/origin/${BRANCH_NAME}"
    if [ $? -eq 0 ]; then
        echo "${BRANCH_NAME} found, closing"
        git push origin :$BRANCH_NAME
        git branch -D $BRANCH_NAME
    fi
    
    cd ..
done
