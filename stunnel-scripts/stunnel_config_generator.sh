#!/usr/bin/env bash

# Combine all the certs in the cluster CA into one file
CA_CERTS=/tmp/cluster-ca.crt
cat /etc/cluster-ca-certs/*.crt > "$CA_CERTS"

echo "pid = /usr/local/var/run/stunnel.pid"
echo "foreground = yes"
echo "debug = $LOG_LEVEL"
echo "sslVersion = all"

cat <<-EOF
[zookeeper-2181]
client = yes
CAfile = ${CA_CERTS}
cert = /etc/cluster-operator-certs/cluster-operator.crt
key = /etc/cluster-operator-certs/cluster-operator.key
accept = 0.0.0.0:2181
connect = ${STRIMZI_ZOOKEEPER_CONNECT}
delay = yes
verify = 2

EOF