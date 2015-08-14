PROJECTS='cps_java
cps_sparkle_java
cps_verizon_java
dist_cache_java
finder_api
finder_internal_api
verizon_am
verizon_mtas
verizon_revo
verizon_spg
verizon_ub_api'

for pro in $PROJECTS; do
    echo "### processing project: $pro ###"
    git clone git@git.locationlabs.com:$pro -b trunk --recursive
    #ssh git@git.locationlabs.com closebranch $pro vci-pilot-release1 "No more release planned for VCI pilot"
done
