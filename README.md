# Bosh 2.0 Concourse Manifest

## Directory Structure on Local Workstation

I store my cloud config ops files in a distinct directory (see [here](https://bosh.io/docs/init-vsphere.html)):

```
~
|-- deployments
|---- bosh-1
|---- concourse
|-- github.com
|---- cloudfoundry
|------ bosh-deployment
```

This directory structure contains a clone of the [bosh-deployment](https://github.com/cloudfoundry/bosh-deployment) repository. The repository remains unmodified, it is manipulated using ops files.

In this example, ~/deployments/concourse contains the files in this repository.

## Documentation Links

* [Concourse Bosh Release](https://bosh.io/releases/github.com/concourse/concourse)
* [Concourse CI bosh cluster documentation](https://concourse.ci/clusters-with-bosh.html)

## Setup

```bash
# create the deployment directory
mkdir ~/deployments

# clone the repo and rename
cd ~/deployments
git clone https://github.com/patrickhuber/concourse-bosh-2.git
mv concourse-bosh-2 concourse

# set working directory
cd ~/deployments/concourse
```

## Update shell scripts

The provided shell scripts are coded for 192.168.2.0 as the concourse static IP. A static IP may not be relevant to your deployment if you are using another cpi. This example was originally developed for VSphere. 

int-concourse.sh

```bash
bosh interpolate -d concourse \
     concourse.yml \
     -v atc_static_ip=192.168.2.0 \
     --vars-file=creds.yml
```

deploy-concourse.sh

```bash
bosh deploy -d concourse \
     concourse.yml \
     -v atc_static_ip=192.168.2.0 \
     --vars-file=creds.yml
```

Replace the atc_static_ip with the desired IP of your atc deployment. 

## Update Cloud Config (if using static IP)

You will also need to modify your cloud config. This ops file can be added to your bosh deployment script to reserve static ips with a variable. 

static-ips.yml

```yml
- type: replace
  path: /networks/name=default/subnets/0/static?
  value: ((internal_static_ips))
```

Assuming you have the directory structure above, jump into your bosh deployment directory and redeploy with the given ops file.

```bash
cd ~/deployments/bosh-1

vi create-env.sh
```

```
# Fill below variables (replace example values) and deploy the Director
# I just pulled this from the bosh vsphere exaxmple https://bosh.io/docs/init-vsphere.html and added in the variable for the atc static IP.
# You will need to supply your own values for the internal_* and vcenter_* variables. 
bosh interpolate ~/github.com/cloudfoundry/bosh-deployment/bosh.yml \
    --state=state.json \
    --vars-store=creds.yml \
    -o ~/github.com/cloudfoundry/bosh-deployment/vsphere/cpi.yml \
    -o static-ips.yml \
    -v director_name=bosh-1 \
    -v internal_cidr=10.0.0.0/24 \
    -v internal_gw=10.0.0.1 \
    -v internal_ip=10.0.0.6 \
    -v internal_static_ips=[192.168.2.0] \
    -v network_name="VM Network" \
    -v vcenter_dc=my-dc \
    -v vcenter_ds=datastore0 \
    -v vcenter_ip=192.168.0.10 \
    -v vcenter_user=root \
    -v vcenter_password=vmware \
    -v vcenter_templates=bosh-1-templates \
    -v vcenter_vms=bosh-1-vms \
    -v vcenter_disks=bosh-1-disks \
    -v vcenter_cluster=cluster1 \
    > interpolated-cloud-config.yml

bosh update-cloud-config interpolated-cloud-config.yml    
```

## Generate creds.yml file

Run the interpolate script now that you have updated the int-concourse.sh script to generate the creds file. 

```
cd ~/deployments/concourse
./int-concourse.sh
```

## Deploy Concourse

Assuming you have updated your deploy-concourse.sh file, run:

```
cd ~/deployments/concourse
./deploy-concourse.sh
```
