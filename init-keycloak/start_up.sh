#!/bin/bash
set -e

echo "Building..."
/opt/keycloak/bin/kc.sh build

echo "Start keycloak with --optimized and --import-realm flag..."
# Start Keycloak normally
exec /opt/keycloak/bin/kc.sh start --optimized --import-realm
