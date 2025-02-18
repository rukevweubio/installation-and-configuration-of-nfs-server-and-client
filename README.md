# Samba Server Installation and Configuration

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation Steps](#installation-steps)
- [Configuration Steps](#configuration-steps)
- [Testing and Verification](#testing-and-verification)
- [Troubleshooting](#troubleshooting)
- [Maintenance](#maintenance)
- [Contributing](#contributing)
- [License](#license)

## Introduction
Samba is an open-source software suite that provides file and print services for SMB/CIFS clients. It enables seamless file and printer sharing 
between Linux/Unix servers and Windows clients, making it an essential tool for organizations with mixed
operating system environments. This project guides users through installing, configuring, and maintaining a Samba server on Ubuntu 22.04.

## Prerequisites
Before proceeding, ensure the following prerequisites are met:
Hardware Requirements:
A machine running Ubuntu 22.04 (physical or virtual).
At least 1 GB of free disk space.
Static IP address configured for the server

## Software Requirements:
Operating System: Ubuntu 22.04 LTS.
Required Packages:
samba: The main Samba package.
smbclient: For testing Samba shares from the command line.

## Installation Steps

Follow these steps to install the Samba server:

1. Update the system:
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo systemctl start smbd
   sudo systemctl enable smbd
   ```
## Configuration Steps
``` bash
sudo mkdir -p /srv/samba/shared
sudo chmod 777 /srv/samba/shared
Edit the Samba configuration file (/etc/samba/smb.conf):

[shared]
    comment = Shared Folder
    path = /srv/samba/shared
    browseable = yes
    read only = no
    guest ok = no
    valid users = sambauser
create samba user :
sudo useradd sambauser -M 
sudo smbpasswd -a sambauser
Test the configuration
testparm

```

## Testing and Verification
To verify that the Samba server is working:
From a Linux client:
bash
```
sudo mount -t cifs //192.168.1.100/shared /mnt -o username=sambauser,password=yourpassword
From a Windows client:
Open File Explorer and enter \\192.168.1.100\shared.
Authenticate with the Samba user credentials.

```
## Troubleshooting
Common issues and their solutions:
Issue: Unable to connect to the Samba server.
Solution: Check firewall rules and ensure the Samba service is running

## Maintenance
 update the samba package 
 ```
 sudo apt update && sudo apt upgrade -y
```

## Screenshot

Below is a screenshot of the NFS server and client configuration:

![NFS Server and Client Configuration](https://github.com/rukevweubio/installation-and-configuration-of-nfs-server-and-client/blob/main/Screenshot%20(420).png "NFS Setup Screenshot")
 ## screenshot to show  disk partition 
 ![NFS Server and Client Configuration](https://github.com/rukevweubio/installation-and-configuration-of-nfs-server-and-client/blob/main/Screenshot%20(416).png)
