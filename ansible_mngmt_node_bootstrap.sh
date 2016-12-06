#!/bin/bash

DEBIAN_FRONTEND=noninteractive

sudo apt-get -yq install software-properties-common

#additional repo setup and update
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:ansible/ansible
sudo apt-get update

#install needed packages
sudo apt-get -yq install ansible python-pip sublime-text-installer git 

sudo pip install "pywinrm>=0.1.1"

#add ssh key. revise this later as it's not really secure
eval "$(ssh-agent -s)"
#//TODO add key coping
sudo chmod -R 0700 /home/localusr/.ssh
sudo chown -R localusr /home/localusr/.ssh

ssh-add ~/.ssh/id_rsa

sudo rm /etc/ssh/ssh_known_hosts
sudo sh -c "dig +short github.com | (echo github.com && cat) | ssh-keyscan -f - >> /etc/ssh/ssh_known_hosts"
#clone ansible configuration
git clone git@github.com:yumapos/yumapos-ansible-deploy ~/deployment/ansible/

wget https://www.realvnc.com/download/file/vnc.files/VNC-6.0.1-Linux-x64-DEB.tar.gz -O ~/VNC-6.0.1-Linux-x64-DEB.tar.gz

tar xf ~/VNC-6.0.1-Linux-x64-DEB.tar.gz -C ~/
sudo dpkg -i ~/VNC-Server-6.0.1-Linux-x64.deb 
sudo vnclicense -add H62DH-62DED-RG5ES-M9G6C-QG87A

rm ~/VNC*

sudo systemctl start vncserver-x11-serviced




