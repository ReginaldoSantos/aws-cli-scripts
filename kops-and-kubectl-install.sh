#!/bin/bash

########################################################################
#
# AWS: Kubernetes with KOPS
#
# Installing KOPS and KubeCtl in local linux machine
#
########################################################################

# Installing KOPS
# Download latest release: https://github.com/kubernetes/kops/releases

chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

# Installing kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl


