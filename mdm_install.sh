
#!/bin/bash
sudo yum -ytq install wget libaio numactl
sudo rpm -i https://scaleio-source.s3.amazonaws.com/1.32/EMC-ScaleIO-mdm-1.32-403.2.el7.x86_64.rpm

while [ ! -f  /tmp/all_sds ];
do
    echo "SDS File Not yet Found - Sleeping before continuining"
    sleep 10
done


cat <<'EOF' > /tmp/install.sh
#!/bin/bash -i

MDM=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

scli --mdm --add_primary_mdm --primary_mdm_ip $MDM --accept_license
sleep 5
scli --login --mdm_ip $MDM --username admin --password admin
scli --mdm_ip $MDM --set_password --old_password admin --new_password password123!
scli --login --mdm_ip $MDM --username admin --password password123!
scli --add_protection_domain --mdm_ip $MDM --protection_domain_name pdomain
scli --add_storage_pool --mdm_ip $MDM --protection_domain_name pdomain --storage_pool_name pool1
sleep 5

for sds_ip in `cat /tmp/all_sds`; do
  scli --add_sds --mdm_ip $MDM --sds_ip $sds_ip --device_path /dev/xvdb --sds_name $sds_ip --protection_domain_name pdomain --storage_pool_name pool1
done

EOF
