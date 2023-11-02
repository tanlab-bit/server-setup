#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Check if the file path is provided as a command line argument
if [ $# -ne 1 ]; then
  echo -e "[➤] Usage: $0 <file>"
  exit 1
fi

file="$1"

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

# Check if the file exists and is readable
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
  echo -e "[✘] '$file' not found or unreadable, exiting !"
  exit 1
fi

# Create users from the file
for i in $( cat $file ); do
  if id -u $i >/dev/null 2>&1; then
    echo -e "[-] User" $i "already exists, skipping -"
  else
    # Create a user and adding into default group gpuuser
    useradd -g gpuuser -s /bin/bash -d /home/$i -m $i
    # Set the password
    echo -e $i:asdfghjkl123 | chpasswd
    echo -e "[➤] Created user with name" $i "and added into group gpuuser >>>"
  fi
done

echo -e "[✔] Done!"
