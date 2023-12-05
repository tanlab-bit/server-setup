#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# See: https://docs.anaconda.com/anaconda/install/multi-user/
# Miniforge from: https://github.com/conda-forge/miniforge#miniforge3
echo -e "[➤] Multi-user installation for Miniforge >>>"

# Check for root access
if [ "$EUID" -ne 0 ]
  then echo -e "[✘] Please run as root, exiting >>>"
  exit
fi

# Create new group called gpuuser
if ! [ $(getent group gpuuser) ]; then
  groupadd gpuuser
  echo -e "[➤] Created new group 'gpuuser' >>>"
fi

miniforge_path=/opt/miniforge

if [ -d $miniforge_path ]; then
  # Change ownership
  chgrp -R gpuuser $miniforge_path
  echo -e "[➤] Changed ownership for path" $miniforge_path "to group 'gpuuser' >>>"
  # Change permissions to read and execute
  chmod 755 -R $miniforge_path
  echo -e "[➤] Changed permissions for path" $miniforge_path "to 755 >>>"

  # Append Miniforge
  echo -e "export PATH=$miniforge_path/bin:$PATH" >> /etc/profile
  echo -e "[➤] Added Miniforge bin PATH to '/etc/profile' >>>"
  echo -e "[✔] Done!"
else
  echo -e "[✘] Path" $miniforge_path "not found! Please check Miniforge installation path >>>"
  echo -e "[✘] Aborting ..."
fi
