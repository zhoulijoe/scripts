#!/bin/bash

FALLBACK_MODULES="\
att_3pp_events \
amqp_java \
c2dm \
chaff_java \
cps_java \
cps_sparkle_java \
db_context_java \
db_java \
ddserver \
dist_cache_java \
factory_java \
finder_billing_base \
base \
finder_billing_generic \
generic \
finder_billing_att \
att \
finder_billing_verizon \
verizon \
finder_event_processor \
finder_internal_api \
geo \
geo_base \
geo_base_test \
geo_mysql \
gradle_dist \
history_store_client_java \
http_java \
integration_sparkle \
location_server \
location_service \
location_types \
logging_java \
logging_java_test \
maplink \
maplink_test \
mapserver \
mapserver_test \
mock_sparkle \
navteq_revgeo \
phonenumber_java \
psc \
dpkg \
redis_java \
schedule_java \
sms_java \
sparkle_client_java_proxy_v3 \
sparkle_client_java_proxy_v4 \
spring_java \
ssl_java \
stats_java \
types_java \
test_java \
text_java \
verizon_am \
verizon_mtas \
verizon_spg \
virtualearth \
web_java \
ws_java"

while getopts n OPTION; do
     case $OPTION in
         n)
             FALLBACK_MODULES=''
             ;;
     esac
done

export FALLBACK_MODULES
