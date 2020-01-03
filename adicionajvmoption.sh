#!/bin/sh
SERVERGROUP=($(/opt/jboss/jboss/bin/jboss-cli.sh --connect  --commands=ls\ server-group))

for SERVER in ${SERVERGROUP[@]}
do
/opt/jboss/jboss/bin/jboss-cli.sh --connect <<EOF
batch
echo "-------- Adicionando parametros da JVM $SERVER ----------- "
/server-group=$SERVER/jvm=default:add-jvm-option(jvm-option="-XX:+UseParallelGC")
run-batch
exit
EOF
done

