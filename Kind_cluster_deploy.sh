#!/bin/bash

# Set the desired KinD cluster name
CLUSTER_NAME="my-kind-cluster"

# Check if KinD is installed
if ! command -v kind &> /dev/null; then
    echo "KinD is not installed. Please install it from https://kind.sigs.k8s.io/docs/user/quick-start/"
    exit 1
fi

# Check if the cluster already exists
if kind get clusters | grep -q "$CLUSTER_NAME"; then
    echo "Cluster '$CLUSTER_NAME' already exists. Skipping deployment."
    exit 0
fi

# Define the KinD cluster configuration
cat <<EOF | kind create cluster --name "$CLUSTER_NAME" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
EOF

# Verify cluster creation
if [ $? -eq 0 ]; then
    echo "KinD cluster '$CLUSTER_NAME' created successfully!"
else
    echo "Failed to create KinD cluster '$CLUSTER_NAME'."
    exit 1
fi
