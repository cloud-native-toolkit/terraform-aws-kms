#!/bin/bash
alias_name="$(cat terraform.tfvars | grep  "kms_alias" | awk -F'=' '{print $2}' | sed 's/[""]//g'| sed 's/[[:space:]]//g')"
REGION="$(cat terraform.tfvars | grep  "region" | awk -F'=' '{print $2}' | sed 's/[""]//g' | sed 's/[[:space:]]//g')"

echo "alias_name: ${alias_name}-key"
echo "REGION: ${REGION}"

#aws configure set region ${REGION}
#aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
#aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}

echo "Checking KMS exists with Name in AWS: ${alias_name}-key"

KMS_ID=""
KMS_ID=$(aws kms describe-key  --key-id alias/$alias_name-key --region $REGION | grep KeyId | awk -F':' '{print $2}')

echo "alias_name: ${alias_name}"
if [[(${KMS_ID} == "") ]]; then
  echo "KMS NOT found "
   exit 1
else
    echo "KMS Found - ${KMS_ID}"    
fi
