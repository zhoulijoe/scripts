#!/bin/bash

OLD_SCHEMA_DIR=/ext/build/finder_verizon/1.3-SCALABILITY/best/ubuntu-10.04-64/core/deb-build-dir/wmverizoncore_*/opt/wm/etc/wmverizoncore
NEW_SCHEMA_DIR=/var/tmp/zhou/build/finder_verizon/1.3-VCI-SCALABILITY/core/deb-build-dir/wmverizoncore_*/opt/wm/etc/wmverizoncore

SCHEMA_DIFF_DIR=./schema_diff

if [ ! -d $SCHEMA_DIFF_DIR ]; then
    mkdir $SCHEMA_DIFF_DIR
fi

SCHEMA_FILES='finder-common-hibernate-mysql.sql
finder-billing-verizon-mysql.sql
cps-verizon-mysql.sql'

for F in $SCHEMA_FILES; do
    cp $OLD_SCHEMA_DIR/$F $SCHEMA_DIFF_DIR/$F.old

    cp $NEW_SCHEMA_DIR/$F $SCHEMA_DIFF_DIR/$F.new

    diff -C 10 $SCHEMA_DIFF_DIR/$F.old $SCHEMA_DIFF_DIR/$F.new > $SCHEMA_DIFF_DIR/$F.diff
done