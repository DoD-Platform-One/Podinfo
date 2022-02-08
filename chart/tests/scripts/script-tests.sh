#!/bin/bash
set -ex

echo "-----------------------------------------"
echo "BEGIN podinfo jwt test"
echo "-----------------------------------------"
TOKEN=$(curl -sd 'test' ${URL}/token | jq -r .token) &&
curl -sH "Authorization: Bearer ${TOKEN}" ${URL}/token/validate | grep test
echo "-----------------------------------------"
echo "END podinfo jwt test"
echo "-----------------------------------------"
