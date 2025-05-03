#!/bin/bash
set -e

echo "Building..."
/opt/keycloak/bin/kc.sh build


# echo "Start keycloak temporarily..."
# # Start keycloak temporarily in background
# /opt/keycloak/bin/kc.sh start-dev &
# SERVER_PID=$!

# # Wait until Keycloak is ready
# until curl -s http://localhost:8080/realms/master; do
#   echo "Waiting for Keycloak..."
#   sleep 2
# done

# # Create realm if not exists
# if ! curl -s http://localhost:8080/admin/realms/myrealm; then
#   echo "Bootstrapping Keycloak with realm + client..."

#   /opt/keycloak/bin/kcadm.sh config credentials \
#     --server http://localhost:8080 \
#     --realm master \
#     --user bootadmin \
#     --password bootpassword

#   # Create realm
#   /opt/keycloak/bin/kcadm.sh create realms -s realm=myrealm -s enabled=true

#   # Create client
#   /opt/keycloak/bin/kcadm.sh create clients -r myrealm \
#     -s clientId=admin-app \
#     -s enabled=true \
#     -s publicClient=false \
#     -s secret="4onyI68HdVm0nv7tcVZu7NzGjdzO9i0f" \
#     -s 'redirectUris=["*"]' \
#     -s 'directAccessGrantsEnabled=true' \
#     -s 'serviceAccountsEnabled=true'

#   # Assign all roles to service account
#   CLIENT_ID=$(/opt/keycloak/bin/kcadm.sh get clients -r myrealm --fields id,clientId | jq -r '.[] | select(.clientId=="admin-app") | .id')
#   SERVICE_ACCOUNT_ID=$(/opt/keycloak/bin/kcadm.sh get clients/$CLIENT_ID/service-account-user -r myrealm --fields id | jq -r '.id')

#   # Assign realm roles
#   REALM_ROLES=$(/opt/keycloak/bin/kcadm.sh get roles -r myrealm | jq -c '.[]')
#   for role in $(echo "$REALM_ROLES" | jq -r '.name'); do
#     /opt/keycloak/bin/kcadm.sh add-roles -r myrealm --uusername $SERVICE_ACCOUNT_ID --rolename $role
#   done
# fi

# # Kill temporary keycloak
# kill $SERVER_PID
# wait $SERVER_PID || true

echo "Start keycloak with --optimized flag..."
# Start Keycloak normally
exec /opt/keycloak/bin/kc.sh start --optimized
