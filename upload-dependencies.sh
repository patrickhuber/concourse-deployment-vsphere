bosh upload-stemcell https://s3.amazonaws.com/bosh-core-stemcells/vsphere/bosh-stemcell-3445.2-vsphere-esxi-ubuntu-trusty-go_agent.tgz
bosh upload-release https://bosh.io/d/github.com/concourse/concourse
bosh upload-release https://bosh.io/d/github.com/cloudfoundry/garden-runc-release
