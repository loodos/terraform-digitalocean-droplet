#!/bin/sh

# decode banner content
banner_content=$(echo "${banner_content_base64}" | base64 --decode)

# create sshd_banner file
echo "$banner_content" > "/etc/ssh/sshd_banner"

# change banner configuration
sed -i -e "/^#Banner/s/^.*$/Banner \/etc\/ssh\/sshd_banner/" /etc/ssh/sshd_config
/etc/init.d/ssh reload