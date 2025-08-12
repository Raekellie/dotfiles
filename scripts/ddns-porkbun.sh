#!/usr/bin/env -S bash -Eeuo pipefail

DOMAIN_NAME='raquellie.com'
SUBDOMAIN_NAME='*'

COMMAND_GET_IP="curl --silent 'https://ifconfig.me/ip'"
COMMAND_RESOLVE_DOMAIN="dig $SUBDOMAIN_NAME.$DOMAIN_NAME | awk '/^;; ANSWER SECTION:$/ { getline ; print \$5 }'"

KEY_API=""
KEY_SECRET=""

CURRENT_IP=$(eval $COMMAND_GET_IP)
CURRENT_DOMAIN_IP=$(eval $COMMAND_RESOLVE_DOMAIN)

PORKBUN_ENDPOINT="https://api.porkbun.com/api/json/v3/dns/editByNameType/$DOMAIN_NAME/A/$SUBDOMAIN_NAME"

COMMAND_UPDATE_DNS="curl --silent --header 'Content-Type: application/json' --request POST --data '{\"secretapikey\":\"$KEY_SECRET\",\"apikey\":\"$KEY_API\",\"content\":\"$CURRENT_IP\",\"ttl\":\"600\"}' $PORKBUN_ENDPOINT"

if [[ "$CURRENT_IP" == "$CURRENT_DOMAIN_IP" ]]; then
	echo "IP unchanged."
else
	echo "New IP: $CURRENT_IP. Sending API request."
	eval $COMMAND_UPDATE_DNS
fi
