#!/bin/bash
set -e -o pipefail

# Update kubeconfig
aws eks update-kubeconfig --region us-east-1 --name cluster --profile uda2;

echo "Fetching IAM github-action-user ARN"
userarn=$(aws iam get-user --profile uda2 --user-name github-action-user | jq -r .User.Arn)

# Download tool for manipulating aws-auth
echo "Downloading tool..."
curl -X GET -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.6.2/aws-iam-authenticator_0.6.2_linux_amd64 -o aws-iam-authenticator
chmod +x aws-iam-authenticator

echo "Updating permissions"
./aws-iam-authenticator add user --userarn="${userarn}" --username=github-action-role --groups=system:masters --kubeconfig="$HOME"/.kube/config --prompt=false

echo "Cleaning up"
rm aws-iam-authenticator
echo "Done!"