# Infra tools
This repo contains Infra as Code along with the tools to use.

## Workspace
It is a custom docker image that contains all the tools you might need to use this repo.

### Requirements
* Working docker
* Your linux user is able to run docker commands without sudo

##### Network connectivity
For ansible to work your host needs direct network connection with the internal azure virtual networks. You can use openvpn connection for that or run this container on a host in an azure vm. Or use ssh passthrough for all IPs as shown in [Tune your ~/.ssh/config](#SSH) for openvpn.

### Image content
* kubectl
* ansible /w libs
* azure libs and cli
* packer
* terraform
* terragrunt
* packer
* some default software (curl, tar, mc, etc...)

### Features
#### Home dir passthrough
The user you start the container with is going to be created inside the container. And you have your home dir mounted inside the container.

#### SSH keys passthrough
As long as your home dir is mounted all your keys in `~/.ssh/` directory are effective. But the most important that your ssh-agent keys are passed through.

Please use keepass with ssh-agent and don't store you keys as files.

### Usage
Run this script to jump inside: `./workspace/start.sh`

In case the Dockerfile were updated use the command: `./workspace/start.sh build`

Use `./workspace/start.sh build --no-cahce` if you get some 404 while downloading packages and failed build.

#### SSH

Tune your ~/.ssh/config

```
Host *
# Avoid server key checking
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
# Use your ssh keys on remote hosts without transfering them
  ForwardAgent yes
  AddKeysToAgent yes
# Misc...
  SendEnv LANG LC_*
  HashKnownHosts yes
  GSSAPIAuthentication yes
  ServerAliveInterval 100
```

### Terraform

Terragrant is installed. It is a nice wrapper for terraform.

#### Easy targeting using regexp pattern
```
tfp apply -pattern=.*vm_02.*
```
Use `tfp` command instead of `terragrunt`. It is available inside the container. Originally I got it from here : https://github.com/schneidexe/tfp
