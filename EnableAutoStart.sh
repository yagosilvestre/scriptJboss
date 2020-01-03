#!/bin/sh

HOST=($(/opt/jboss/jboss/bin/jboss-cli.sh --connect  --commands=ls\ host))
for HOST in ${HOST[@]}
do
SERVER=($(/opt/jboss/jboss/bin/jboss-cli.sh --connect  --commands=ls\ host=$HOST/server))
for SERVER in ${SERVER[@]}
do
/opt/jboss/jboss/bin/jboss-cli.sh --connect <<EOF
batch
echo "--- Habilitando auto-start do server $SERVER no host $HOST ---"
/host=$HOST/server-config=$SERVER:write-attribute(name=auto-start,value=true)
run-batch
exit
EOF
done
done
