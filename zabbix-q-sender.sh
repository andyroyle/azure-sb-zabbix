#!/bin/bash
dirBase="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
datasend_zabbix="$dirBase/dataSend_zabbix_$2_$4.conf"
queuecount=`$dirBase/azure-sb.py -h $2 -k $3 -a queue-count -t $4`
hostname="$2.servicebus.windows.net"

echo "$hostname servicebus.queuecount $queuecount" > $datasend_zabbix
zabbix_sender -z $1 -i $datasend_zabbix
