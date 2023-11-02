# Setup scripts

Essential scripts for setting up a new server.

## Usage

| Script                                | Description                                                                        | Usage                                            |
| :------------------------------------ | :--------------------------------------------------------------------------------- | :----------------------------------------------- |
| `create-gpuuser.sh`                   | Create new user under group `gpuuser`.                                             | `sudo ./create-gpuuser.sh <username>`            |
| `batch-create-gpuuser.sh`             | Create new users under group `gpuuser` with usernames pulled from `usernames.txt`. | `sudo ./batch-create-gpuuser.sh <usernames.txt>` |
| `batch-del-user.sh`                   | Delete users with usernames pulled from `usernames.txt`.                           | `sudo ./batch-del-user.sh <usernames.txt>`       |
| `mambaforge-multiuser-postinstall.sh` | Post-installation script for Mambaforge.                                           | `sudo ./mambaforge-multiuser-postinstall.sh`     |
