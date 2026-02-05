#!/usr/bin/env -S bash -Eeuo pipefail

DOMAIN_NAME='raquellie.com'

COMMAND_GET_IP="curl --fail --silent 'https://ifconfig.me/ip'"
COMMAND_RETRIEVE_RECORD="dig +short $DOMAIN_NAME"

KEY_API=""
KEY_SECRET=""

if ! CURRENT_IP="$(eval $COMMAND_GET_IP)"; then
	echo "[ERROR] Failed to retrieve the machine IP."
	exit 1
fi

PORKBUN_UPDATE="https://api.porkbun.com/api/json/v3/dns/editByNameType/$DOMAIN_NAME/A"
COMMAND_UPDATE_DNS="curl --silent --header 'Content-Type: application/json' --request POST --data '{\"secretapikey\":\"$KEY_SECRET\",\"apikey\":\"$KEY_API\",\"content\":\"$CURRENT_IP\",\"ttl\":\"600\"}' $PORKBUN_UPDATE"


if [[ "$CURRENT_IP" == "$(eval $COMMAND_RETRIEVE_RECORD)" ]]; then
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
