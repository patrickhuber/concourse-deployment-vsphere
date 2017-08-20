bosh interpolate -d concourse \
     concourse.yml \
     -v atc_static_ip=192.168.2.0 \
     --vars-file=creds.yml
