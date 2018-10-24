azure-sb-zabbix
---

QUEUEs

A python script to monitor the health of an azure-servicebus namespace from zabbix.

Intended to be called from zabbix as a user-parameter.

usage topic:
```shell
> azure-sb.py -k accesskey -h my-servicebus -a topic-size -t mytopic
4534567
```

usage queue:
```shell
> azure-sb.py -k accesskey -h my-servicebus -a queue-count -t myqueue
4534567
```

```shell
Usage: azure-sb.py [options]

This Zabbix plugin checks the health of an azure-servicebus instance.

Options:
  --help                show this help message and exit
  -h HOST, --host=HOST  The namespace you want to connect to
  -k KEY, --key=KEY     The key to use for authentication
  -n KEYNAME, --keyname=KEYNAME The key name that the given access key relates to (default RootManageSharedAccessKey)
  -a ACTION, --action=ACTION The action you want to take
  -t TOPIC, --topic=TOPIC The topic you want to interrogate
  -q QUEUE, --queue=QUEUE The topic you want to interrogate
  -s SUBSCRIPTION, --subscription=SUBSCRIPTION The subscription you want to interrogate
```

###actions

- `topic-size`: print the size (in bytes) of the given topic (int)
- `topic-percent`: print the topic size as a percentage of the max size (float, 0 to 1)
- `subscription-active`: print the message count of the given subscription (int)
- `queue-count`: print the size (in bytes) of the given topic (int)

###examples

```
> ./azure-sb.py -h my-servicebus -k XjGbthddfslAD8= -a topic-size -t mytopic
1563663668
> ./azure-sb.py -h my-servicebus -k XjGbthddfslAD8= -a topic-percent -t mytopic
0.01822
> ./azure-sb.py -h my-servicebus -k XjGbthddfslAD8= -a subscription-active -t mytopic -s mysubscription
21
> ./azure-sb.py -h my-servicebus -k XjGbthddfslAD8= -a queue-count -t myqueue
1563663668
```

###using with zabbix_sender
If you want to use this script with the zabbix_sender utility then there's a [shell script provided](zabbix-sender.sh) which will invoke azure-sb.py and pipe the result to zabbix_sender.

Usually you would invoke this from a cron-job (or similar)

Queue
```
*/2 * * * * /path/to/azure-sb-zabbix/zabbix-q-sender.sh myzabbix.server.com my-servicebus-namespace accesskey myqueue > /dev/null 2>&1
```
Topic
```
*/2 * * * * /path/to/azure-sb-zabbix/zabbix-sender.sh myzabbix.server.com my-servicebus-namespace accesskey mytopic > /dev/null 2>&1
```