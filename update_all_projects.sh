#!/bin/bash

PROJECT_DIRS=`find ./* -maxdepth 0 -type d`

for dir in $PROJECT_DIRS; do
    pushd .
    cd $dir
    if [ -d .git ]; then
        echo "### Updating git project: "$dir" ###"
        git pull --rebase
        git submodule update --init
        echo ""
    elif [ -d .svn ]; then
        echo "### Updating svn project: "$dir" ###"
        svn update
        echo ""
    fi
    popd
done