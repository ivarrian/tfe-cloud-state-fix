#!/bin/bash
STATE_FILE=$1
WORKSPACE_ID=$2
# make backup before doing anything
cp $STATE_FILE "$STATE_FILE.orig"
cp payload.json.template payload.json
# find current SERIAL
SERIAL=$(cat $STATE_FILE | jq -r '.serial')
SERIAL_INCREMENT=$(( $SERIAL + 1 ))
LINEAGE=$(cat $STATE_FILE | jq -r '.lineage')
MD5=$(cat $STATE_FILE | md5)
BASE64=$(cat $STATE_FILE | base64)
sed -E -i.bak "s/\"serial\"\:[[:space:]]$SERIAL/\"serial\"\: $SERIAL_INCREMENT/g" $STATE_FILE
MD5=$(cat $STATE_FILE | md5)
BASE64=$(cat $STATE_FILE | base64)
sed -i.bak "s/%SERIAL%/$SERIAL_INCREMENT/g" payload.json
sed -i.bak "s/%LINEAGE%/$LINEAGE/g" payload.json
sed -i.bak "s/%MD5%/$MD5/g" payload.json
sed -i.bak "s/%STATE%/$BASE64/g" payload.json

curl --header "Authorization: Bearer $TOKEN" --header "Content-Type: application/vnd.api+json"   --request POST   --data @payload.json https://app.terraform.io/api/v2/workspaces/$WORKSPACE_ID/state-versions