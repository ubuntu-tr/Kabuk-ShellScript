#!/bin/bash
#----------------------------------------------------
# Özet: Ubuntu için Lamp Yükleyicisi
# Yazar: @BTaskaya
# Kaynak: https://github.com/BTaskaya
#----------------------------------------------------

echo "Chrome Installer by $(tput bold)$(tput setaf 2)@BTaskaya$(tput sgr0)"
echo ""
echo ""
echo ""
sudo apt-get update

echo ""
echo ""
echo ""
echo "Installation Started"
echo ""
echo ""
echo ""
sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt
echo ""
echo ""
echo ""
echo "Installation Finished"
echo ""
echo ""
echo ""
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'
sudo apt-get -y install mysql-server
echo ""
echo ""
echo ""

service apache2 restart && service mysql restart > /dev/null

echo ""
echo ""
echo ""
if [ $? -ne 0 ]; then
   echo "$(tput bold)$(tput setaf 1)There is a problem with the installation$(tput sgr0)"
else
   echo "$(tput bold)$(tput setaf 2)Sucessfully Installed Services$(tput sgr0)"
fi

echo ""
echo ""
echo ""
echo "Github.COM/BTaskaya/Ubuntulamp"
