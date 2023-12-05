#!/usr/bin/env bash
# -*- coding: utf-8 -*-

if [ $# -ne 1 ]; then
  echo -e "[➤] Usage: $0 username"
  exit 1
fi

# Check for root access
if [ "$EUID" -ne 0 ]; then
  echo -e "[✘] Please run as root, exiting >>>"
  exit
fi

if ! [ $(getent group gpuuser) ]; then
  # Create new group called gpuuser
  groupadd gpuuser
  echo -e "[➤] No group gpuuser detected so I created one for you >>>"
fi

# Create a user and adding into default group gpuuser
useradd -g gpuuser -s /bin/bash -d /home/$1 -m $1
# Set the password
echo -e $1:asdfghjkl123 | chpasswd
echo -e "[✔] Done! Created user with name" $1 "and added into group gpuuser >>>"
