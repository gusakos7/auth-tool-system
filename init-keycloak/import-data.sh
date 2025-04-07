# Log in using kcadm.sh
/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/ --realm master --user admin --password pass

# Import the realm, clients, and users
/opt/keycloak/bin/kcadm.sh create realms -f /tmp/init-keycloak/whole-realm-fvt.json
/opt/keycloak/bin/kcadm.sh create realms -f /tmp/init-keycloak/whole-realm-sphynx.json
/opt/keycloak/bin/kcadm.sh create users -r fvt -f /tmp/init-keycloak/user-fvt.json
/opt/keycloak/bin/kcadm.sh create users -r sphynx -f /tmp/init-keycloak/user-sphynx.json
