# Concourse Customized Bosh Deployment for VSphere

Utilizes the [concourse bosh deployment](https://github.com/concourse/concourse-deployment) as a submodule. Because this repository doesn't utilize tags, submodules must be pinned to a specific commit instead of a commit tag. 

The deployment has a lab vars file. Currently there is no production vars file. 

## Prerequisites

This deployment requires a Bosh Director with CredHub and UAA installed. 

## Deploying

To deploy, just us the deploy-concourse.sh script

```
./deploy-concourse.sh
```
