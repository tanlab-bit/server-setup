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

# Check if the file exists and is readable
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
  echo -e "[✘] File '$file' does not exist or is not readable."
  exit 1
fi

# Read the file line by line and delete each user
while IFS= read -r username; do
  echo -e "[➤] Deleting user: $username"
  userdel -r "$username"
done < "$file"

echo -e "[✔] Done! You can check the current user list with:"
echo -e "    cat /etc/passwd | cut -d : -f 1"
