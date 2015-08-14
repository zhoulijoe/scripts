#!/bin/bash

EXTRA_GRADLE_OPTS="-x test"

while getopts n OPTION; do
     case $OPTION in
         n)
             EXTRA_GRADLE_OPTS=''
             ;;
     esac
done

export EXTRA_GRADLE_OPTS
