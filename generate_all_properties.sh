#!/bin/bash

display_usage() { 
    echo -e "\nUsage:\n$0 [path to dir] \n" 
} 

if [ $# -lt 1 ]; then
    display_usage
    exit 1
fi

JAR_DIR=`readlink -e $1`
TMP_DIR=tmp
CUR_DIR=`readlink -e .`
RESULT_FILE=$CUR_DIR/all.properties
JAR_FILES="c2dm.jar
cps-java.jar
cps-sparkle-java.jar
cps-verizon-java.jar
finder-api-deprecated.jar
finder-api-hessian-v1.jar
finder-api-soap-server-v1.jar
finder-api-v1-impl.jar
finder-api-v1.jar
finder-api-v2-impl.jar
finder-api-v2.jar
finder-api-v3-impl.jar
finder-api-v3.jar
finder-api-versioning.jar
finder-api.jar
finder-billing-base.jar
finder-billing-generic.jar
finder-billing-verizon.jar
finder-core.jar
finder-event-processor.jar
finder-internal-api.jar
finder-verizon-core.jar
history-store-client-java.jar
http-api.jar
integration_sparkle.jar
kiln_client_java-1.1-SNAPSHOT.jar
logging_java-1.15.jar
sparkle-client-3.2.jar
sparkle-client-4.1.jar
verizon-am-mock-gen-wsdl.jar
verizon-ub-api.jar
verizon_am.jar
verizon_mtas.jar
verizon_revo.jar
verizon_spg-gen-xsd.jar
verizon_spg.jar
wmsftp-java.jar
wmutils-amqp.jar
wmutils-asn1.jar
wmutils-chaff.jar
wmutils-db.jar
wmutils-factory.jar
wmutils-logging.jar
wmutils-schedule.jar
wmutils-sms.jar
wmutils-spring.jar
wmutils-ssl.jar
wmutils-test.jar
wmutils-types.jar
wmutils-web.jar
wmutils-ws.jar"

if [ -f $RESULT_FILE ]; then
    rm $RESULT_FILE
fi
if [ -d $TMP_DIR ]; then
    rm -rf $TMP_DIR
fi
mkdir $TMP_DIR
cd $TMP_DIR

for f in $JAR_FILES ; do
    if [ -f $JAR_DIR/$f ]; then
        jar tf $JAR_DIR/$f | grep "\.properties" | xargs -I {} jar xf $JAR_DIR/$f {}
    fi
done

for f in $(find ./* -name "*.properties"); do
    cat $f >> $RESULT_FILE
    echo -e "properties from $f copied"
done

cd $CUR_DIR
rm -rf $TMP_DIR
