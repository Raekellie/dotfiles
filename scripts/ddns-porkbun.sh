#!/usr/bin/env -S bash -Eeuo pipefail

DOMAIN_NAME='raquellie.com'

COMMAND_GET_IP="curl --fail --silent 'https://ifconfig.me/ip'"

KEY_API=""
KEY_SECRET=""

PORKBUN_RETRIEVE="https://api.porkbun.com/api/json/v3/dns/retrieveByNameType/$DOMAIN_NAME/A"
PORKBUN_UPDATE="https://api.porkbun.com/api/json/v3/dns/editByNameType/$DOMAIN_NAME/A"

if ! CURRENT_IP=$(eval $COMMAND_GET_IP); then
	echo "[ERROR] Failed to retrieve the machine IP."
	exit 1
fi

COMMAND_RETRIEVE_DNS="curl --silent --header 'Content-Type: application/json' --request POST --data '{\"secretapikey\":\"$KEY_SECRET\",\"apikey\":\"$KEY_API\"}' $PORKBUN_RETRIEVE"
COMMAND_UPDATE_DNS="curl --silent --header 'Content-Type: application/json' --request POST --data '{\"secretapikey\":\"$KEY_SECRET\",\"apikey\":\"$KEY_API\",\"content\":\"$CURRENT_IP\",\"ttl\":\"600\"}' $PORKBUN_UPDATE"


if ! CURRENT_DOMAIN_IP=$(eval "$COMMAND_RETRIEVE_DNS" | jq --exit-status --raw-output ".records[].content"); then
	echo "[ERROR] Failed to retrieve the current DNS record."
	exit 1
fi

if [[ "$CURRENT_IP" == "$CURRENT_DOMAIN_IP" ]]; then
	echo "[SUCCESS] DNS record unchanged."
	exit 0
else
	echo "[INFO] IP change detected. New machine IP: $CURRENT_IP. Sending API request..."

	# Easier to handle errors by just checking the output for the "SUCCESS" string rather than extracting the JSON
	if eval "$COMMAND_UPDATE_DNS" | grep -q "SUCCESS"; then
		echo "[SUCCESS] DNS record changed."
		exit 0
	else
		echo "[ERROR] Failed to change the record."
		exit 1
	fi
fi
