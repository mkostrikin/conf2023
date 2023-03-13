#!/bin/bash
#
# Script doing `terraform init` with corresponding parameters
# Assume AWS keys injected into aws configuration or environments Ref: https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-state-storage#create-service-account

for BINNAME in yc jq git terraform; do
    if ! which $BINNAME 1>/dev/null; then
        echo "Tool ${BINNAME} was not found."
        exit 1
    fi
done

ROOT=$(git rev-parse --show-toplevel)
PWD=$(pwd)

if ! [[ -L "${BASH_SOURCE[0]}" ]]; then
    echo "You must not execute this script directly!"
    echo "Instead of this:"
    echo "  1. Go to the working directory of a module."
    echo "  2. Create a symbolic link to 'init.sh' from there."
    echo "  3. Execute the link."
    exit 1
elif ! [[ -L backend.tf ]]; then
    echo "Seems terraform backend configuration is missing"
    echo "Please make sure, symlink to backend.tf"
    echo "is created."
    exit 1
fi

CONFIGPATH="${ROOT}/terraform/tfstate-config.tf.json"

BUCKET_NAME=$(jq -r '.variable.bucket_name.default' "$CONFIGPATH")
BUCKET_KEY="${PWD#"$ROOT"/terraform/}/terraform.tfstate"

echo "Registering object storage for terraform state with the following parameters:
  bucket = ${BUCKET_NAME}
  key    = ${BUCKET_KEY}"

terraform init \
    -get=true \
    -force-copy \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="key=${BUCKET_KEY}"
