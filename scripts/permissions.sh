#!/bin/bash 

# Set www-data user ID:GROUP to same us the Host user
USER_ID=1000
GROUP_ID=1000

if [ ! -d /var/www ]; then
  mkdir -p /var/www/html
fi

# Remove www-data user and group and re-create them with previously configured user and group IDs
userdel -f www-data \
    && if getent group www-data ; then groupdel -f www-data; fi \
    && groupadd -f -g "${GROUP_ID}" www-data \
    && useradd -l -u "${USER_ID}" -g "${GROUP_ID}" -d /var/www www-data \
    && chown -R "${USER_ID}":"${GROUP_ID}" /var/www