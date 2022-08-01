#! /usr/bin/env bash
#doitlive shell: /bin/zsh

export COSIGN_PASSWORD=aVerySecurePassword\!

cosign generate-key-pair

# Create a local cluster
kind create cluster

# Verify it's up and running
kubectl get nodes 

# Let's get things ready for the policy-controller
kubectl create namespace cosign-system

kubectl create secret generic mysecret \
  -n cosign-system \
  --from-file=cosign.pub=./cosign.pub

# Time to actually install it
helm install policy-controller \
  -n cosign-system sigstore/policy-controller \
  --devel \
  --set cosign.secretKeyRef.name=mysecret

# The policy-controller only looks at namespaces with a specific annotation.
# Let's create one!
kubectl apply -f manifests/restricted-namespace.yaml

# Let's try creating a pod using an unsigned nginx image!
# This should fail
kubectl apply -f manifests/bad-pod.yaml

# Now let's try creating a pod with a signed container image!
kubectl apply -f manifests/good-pod.yaml
#Hooray!