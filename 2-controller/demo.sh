#! /usr/bin/env bash
#doitlive shell: /bin/zsh

# Create a local cluster
kind create cluster

# Verify it's up and running
kubectl get nodes 

# We need to add the helm repo so we can actually install Kyverno
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

# Time to actually install it
helm install kyverno kyverno/kyverno -n kyverno --create-namespace --set replicaCount=1

# Watch for Kyverno to spin up
kubectl get pods --watch -A

# Apply the Kyverno policy we've created
kubectl apply -f manifests/kyverno-policy.yaml

# Let's try creating a pod using an unsigned nginx image!
# This should fail
kubectl apply -f manifests/bad-pod.yaml

# Now let's try creating a pod from jeefy/*
kubectl apply -f manifests/good-pod.yaml
#Hooray!

kind delete cluster