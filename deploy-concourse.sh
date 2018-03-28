bosh deploy -d concourse \
     submodules/github.com/concourse/concourse-deployment/cluster/concourse.yml \
     -l submodules/github.com/concourse/concourse-deployment/versions.yml \
     -o submodules/github.com/concourse/concourse-deployment/cluster/operations/static-web.yml \
     -o ops-files/basic-auth.yml \
     -l vars-files/lab.yml \
     -v deployment_name=concourse
