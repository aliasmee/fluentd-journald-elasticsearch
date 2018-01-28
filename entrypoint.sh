#!/usr/bin/dumb-init /bin/bash
set -e

uid=${FLUENT_UID:-1000}

# check if a old fluent user exists and delete it
cat /etc/passwd | grep fluent
if [ $? -eq 0 ]; then
    deluser fluent
fi

# (re)add the fluent user with $FLUENT_UID
useradd -u ${uid} -o -c "" -m fluent
export HOME=/home/fluent

# chown home and data folder
chown -R fluent /home/fluent
chown -R fluent /fluentd

if [[ -z ${FLUENT_ELASTICSEARCH_USER} ]] ; then
    sed -i  '/FLUENT_ELASTICSEARCH_USER/d' /fluentd/etc/${FLUENTD_CONF}
else
    sed -i "s/FLUENT_ELASTICSEARCH_USER/$FLUENT_ELASTICSEARCH_USER/g" /fluentd/etc/${FLUENTD_CONF}
fi

if [[ -z ${FLUENT_ELASTICSEARCH_PASSWORD} ]] ; then
    sed -i  '/FLUENT_ELASTICSEARCH_PASSWORD/d' /fluentd/etc/${FLUENTD_CONF}
else
    sed -i "s/FLUENT_ELASTICSEARCH_PASSWORD/$FLUENT_ELASTICSEARCH_PASSWORD/g" /fluentd/etc/${FLUENTD_CONF}
fi

if [[ -n ${FLUENT_ELASTICSEARCH_HOST} ]]; then
    sed -i "s/FLUENT_ELASTICSEARCH_HOST/$FLUENT_ELASTICSEARCH_HOST/g" /fluentd/etc/${FLUENTD_CONF}
fi

if [[ -n ${FLUENT_ELASTICSEARCH_PORT} ]]; then
    sed -i "s/FLUENT_ELASTICSEARCH_PORT/$FLUENT_ELASTICSEARCH_PORT/g" /fluentd/etc/${FLUENTD_CONF}
fi

exec gosu root "$@"
