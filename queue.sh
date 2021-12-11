#!/usr/bin/env bash
#URL="http://localhost:15672/cli/rabbitmqadmin"

VHOST="bla"
USER="someusername"
PWD="superpassword_of_someusername"

QUEUE="queueueueue"

INPUT_EX="exchange-test"

set_user_and_vhost() {
    rabbitmqctl add_vhost $VHOST
    rabbitmqctl list_vhosts
    rabbitmqctl add_user $USER $PWD
    rabbitmqctl set_user_tags $USER administrator
    rabbitmqctl list_users
}

set_permissions() {
    rabbitmqctl set_permissions -p $VHOST $USER ".*" ".*" ".*"
    rabbitmqctl list_permissions -p $VHOST
}

set_exchanges() {
    rabbitmqadmin declare exchange --vhost=$VHOST --user=$USER --password=$PWD name=$INPUT_EX type=direct durable=true
    rabbitmqctl list_exchanges -p $VHOST
}

set_queues() {
    rabbitmqadmin declare queue --vhost=$VHOST --user=$USER --password=$PWD name=$QUEUE durable=true
    rabbitmqctl list_queues -p $VHOST
}
set_policy() {
    rabbitmqctl set_policy expiry ".*" '{"expires":3600}' --apply-to queues
}
set_bindings() {
    rabbitmqadmin declare binding --vhost=$VHOST --user=$USER --password=$PWD source=$INPUT_EX destination=$QUEUE
    rabbitmqctl list_bindings -p $VHOST
}
set_message() {
    rabbitmqadmin publish --vhost=$VHOST exchange=$INPUT_EX routing_key="key001" payload="Hello World" --user=$USER --password=$PWD properties="{\"delivery_mode\":2}"
}
set_user_and_vhost
set_permissions
set_exchanges
set_queues
set_bindings
set_message

echo "Rabbitmq configured with success."

