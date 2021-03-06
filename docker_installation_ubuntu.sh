#!/bin/bash

        #Author : Excellent
        #Date : 20-Jun-2022

##-------------- Docker Installation Automation script ----------------      
echo "Docker Installation to begin, Please wait .... "
sleep 2
if [ ${USER} != root ]
        then
        echo " You need to have root access to run this script"
        exit 2
fi
#First clean system by removin older versions of docker
echo "Clearing system of all older versions of docker, Please wait .... "    
sleep 2
sudo apt-get remove docker docker-engine docker.io containerd runc -y
if [ $? -eq 0 ]
        then
        echo "All older versions of docker have been clear."
        else
        echo "Older versions of docker were unable to be cleared."
        exit 2
fi
sleep 2

#Setup the docker repo
echo "Getting updates for docker repo, Please wait ...."
sudo apt-get update -y
if [ $? -eq 0 ]
        then 
        echo "Update has been installed"
        else    
        echo "Update failed to install"
        exit 2
fi
sleep 2
echo "installing ca-certificates curl gnupg lsb-release, Please wait .... "
sleep 2
sudo apt-get install ca-certificates curl gnupg lsb-release -y
if [ $? -eq 0 ]
        then
        echo "Packages has been installed successfully."
        else
        echo "Packages failed to install successfully."
        exit 2
fi
sleep 2

#Adding Docker official GPG Key
echo "Adding Docker official GPG Key, Please wait ...."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
if [ $? -eq 0 ]
        then
        echo "Success"
        else
        echo "Failed"
        exit 2
fi
sleep 2

echo "Configuring Docker Repository, Please wait .... "
sleep 2
 echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/kyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
if [ $? -eq 0 ]
        then
        echo "Docker Repository configuration complete."
        else
        echo "Docker Repository configuration incomplete."
        exit 2
fi
sleep 2

#Install the docker engine
echo "Installing the Docker engine, Please wait .... "
sleep 2
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y
sleep 2
if [ $? -eq 0 ]
        then
        echo "Docker Engine installed"
        else
        echo "Docker Engine failed to install"
        exit 2
fi
sleep 2

#Check and alter status of docker daemon
echo "Checking status of Docker daemon, Please wait ...."
sleep 2
systemctl status docker
sleep 2
echo "Now starting Docker daemon, Please wait .... "
sleep 2
systemctl start docker
if [ $? -eq 0 ]
        then
        echo "Docker Daemon is active(running)."
        else
        echo "Docker Daemon is not active(not running)."
        exit 2
fi
sleep 2

echo "Enabling Docker to start on every system boot, Please wait .... "      
sleep 2
systemctl enable docker
sleep 2
if [ $? -eq 0 ]
        then
        echo "Docker Daemon has been enabled successfully"
        else
        echo "Docker Daemon failed to enabled to successfully."
        exit 2
fi
sleep 2

echo "Docker is now up and running on your system!!"

