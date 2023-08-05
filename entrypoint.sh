#!/bin/bash

# Set default values if not provided
: ${ROOT_PASSWORD:="root"}
: ${USERNAME:="root"}

# Set root password
echo "root:$ROOT_PASSWORD" | chpasswd

# Create the user with the provided username and password
useradd -m -s /bin/bash $USERNAME
echo "$USERNAME:$ROOT_PASSWORD" | chpasswd

# Add the user to the sudo group
usermod -aG sudo $USERNAME

# Start the SSH server
/usr/sbin/sshd -D
