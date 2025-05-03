#!/bin/sh

KEYCLOAK_URL="http://keycloak:8080"
REALM_FILE="/init-keycloak/auth-tool-realm.json"
USERNAME="bootadmin"
PASSWORD="bootpassword"

echo "⏳ Waiting for Keycloak to be ready..."

# Wait for Keycloak to respond
until curl -s --fail "$KEYCLOAK_URL/realms/master" > /dev/null; do
  echo "🔁 Still waiting for Keycloak..."
  sleep 2
done

echo "✅ Keycloak is up!"

# Get admin token (without jq)
echo "🔐 Requesting admin token..."
TOKEN=$(curl -s \
  -d "grant_type=password" \
  -d "client_id=admin-cli" \
  -d "username=$USERNAME" \
  -d "password=$PASSWORD" \
  "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" | grep -o '"access_token":"[^"]*' | cut -d':' -f2 | tr -d '"')

if [ -z "$TOKEN" ]; then
  echo "❌ Failed to obtain access token. Exiting."
  exit 1
fi

echo "📦 Importing realm..."

# Attempt to import realm (POST will fail if realm exists — can improve with check later)
curl -s -o /dev/null -w "%{http_code}" -X POST "$KEYCLOAK_URL/admin/realms" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data-binary "@$REALM_FILE" | grep -q "201"

if [ $? -eq 0 ]; then
  echo "✅ Realm imported successfully."
else
  echo "⚠️ Realm already exists or import failed."
fi
