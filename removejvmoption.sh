#!/bin/sh
SERVERGROUP=($(/opt/jboss/jboss/bin/jboss-cli.sh --connect  --commands=ls\ server-group))

for SERVER in ${SERVERGROUP[@]}
do
/opt/jboss/jboss/bin/jboss-cli.sh --connect <<EOF
batch
echo "-------- Removendo parametros da JVM $SERVER ----------- "
/server-group=$SERVER/jvm=default:remove-jvm-option(jvm-option="-XX:+UseG1GC")
run-batch
exit
EOF
done
