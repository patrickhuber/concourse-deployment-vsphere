bosh deploy -d concourse \
     submodules/github.com/concourse/concourse-deployment/cluster/concourse.yml \
     -l submodules/github.com/concourse/concourse-deployment/versions.yml \
     -o submodules/github.com/concourse/concourse-deployment/cluster/operations/static-web.yml \
     -o submodules/github.com/concourse/concourse-deployment/cluster/operations/tls.yml \
     -o submodules/github.com/concourse/concourse-deployment/cluster/operations/encryption.yml \
     -o submodules/github.com/concourse/concourse-deployment/cluster/operations/privileged-https.yml \
     -o ops-files/basic-auth.yml \
     -o ops-files/atc-tls-variables.yml \
     -o ops-files/credhub.yml \
     -l vars-files/lab.yml \
     -v deployment_name=concourse
