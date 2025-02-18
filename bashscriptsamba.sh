#!/bin/bash

echo "Setting up a Samba file system..."
echo "Updating the Linux machine..."
sudo apt update -y

echo "Installing Samba server..."
sudo apt install samba -y
sudo systemctl enable smbd
sudo systemctl start smbd
sudo systemctl status smbd

echo "The server is installed and running."

# Create Samba shared directory
path="/home/sambafolder"
if [ -d "$path" ]; then
    echo "The path exists and is a directory."
else
    echo "The path does not exist. Creating it now..."
    sudo mkdir -p "$path"
fi

sudo mkdir -p "$path/sambafile2"
sudo chown "$USER":"$USER" "$path/sambafile2"
sudo chmod 777 "$path/sambafile2"

echo "Configuring Samba..."
config_file="/etc/samba/smb.conf"
if [ -f "$config_file" ]; then
    echo "The Samba config file exists. Modifying it now..."
    sudo bash -c "cat <<EOF >> $config_file

[sambafiles2]
   comment = Samba Shared Folder
   path = /home/sambafolder/sambafile2
   browseable = yes
   read only = no
   guest ok = no
   valid users = sambauser
EOF"
else
    echo "The Samba configuration file does not exist!"
    exit 1
fi

echo "Creating Samba user..."
sudo useradd -m sambauser
echo "Enter password for Samba user:"
sudo smbpasswd -a sambauser

echo "Restarting Samba service..."
sudo systemctl restart smbd

echo "Testing Samba configuration..."
testparm

echo "Mounting the shared folder..."
sudo mkdir -p /mnt/data
sudo chown sambauser:sambauser /mnt/data
sudo chmod 777 /mnt/data

echo "Enter Samba user password again for mounting:"
read -s password2

sudo mount -t cifs //172.17.18.50/sambafile2 /mnt/data -o username=sambauser,password="$password2"

if [ $? -eq 0 ]; then
    echo "The mount is successful."
else
    echo "The Samba client is not mounted."
fi
