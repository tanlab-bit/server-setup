#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# See: https://docs.anaconda.com/anaconda/install/multi-user/
# Mambaforge from: https://github.com/conda-forge/miniforge#miniforge3
echo -e "[➤] Multi-user installation for Mambaforge >>>"

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

mambaforge_path=/opt/mambaforge

if [ -d $mambaforge_path ]; then
  # Change ownership
  chgrp -R gpuuser $mambaforge_path
  echo -e "[➤] Changed ownership for path" $mambaforge_path "to group 'gpuuser' >>>"
  # Change permissions to read and execute
  chmod 755 -R $mambaforge_path
  echo -e "[➤] Changed permissions for path" $mambaforge_path "to 755 >>>"

  # Append Mambaforge
  echo -e "export PATH=$mambaforge_path/bin:$PATH" >> /etc/profile
  echo -e "[➤] Added Mambaforge bin PATH to '/etc/profile' >>>"
  echo -e "[✔] Done!"
else
  echo -e "[✘] Path" $mambaforge_path "not found! Please check Mambaforge installation path >>>"
  echo -e "[✘] Aborting ..."
fi
