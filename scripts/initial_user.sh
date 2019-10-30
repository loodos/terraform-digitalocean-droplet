#!/bin/sh

# add sudo group, if not exists
if [ $(grep '^sudo\:' /etc/group | wc -l) -lt 1 ]; then
    groupadd --system "sudo"
fi

# sudo group no password
echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/50-sudo-nopasswd

# create user
useradd --shell "/bin/bash" --groups "sudo" --create-home "${initial_user}"

# copy ssh keys
initial_user_path="/home/${initial_user}"
mkdir -p "$initial_user_path/.ssh"
echo -n "${initial_user_sshkeys}" > "$initial_user_path/.ssh/authorized_keys"
chown -R "${initial_user}":"${initial_user}" "$initial_user_path/.ssh"
chmod 0700 "$initial_user_path/.ssh"
chmod 0600 "$initial_user_path/.ssh/authorized_keys"

# remove root password
sed -i -e '/^root:/s/^.*$/root:\*:17939:0:99999:7:::/' /etc/shadow

# remove ssh files which owner is root
rm -f "/root/.ssh/*.pub"
rm -f "/root/.ssh/authorized_keys"

# disable root login
sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
/etc/init.d/ssh reload