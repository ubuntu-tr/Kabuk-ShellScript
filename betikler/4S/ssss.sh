#!/bin/bash

#----------------------------------------------------
# Özet: Kısaca Sunucunuzun temel kurulumunu yapacak basit bir script. ( Simple Server Setup Script - (Shell) )
# Yazar: github.com/BTaskaya | @exec_vim on Twitter
# Kaynak: https://github.com/BTaskaya/4S
#----------------------------------------------------

bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)

echo "${bold}${green} 4S ${normal} - ${bold}ssss.sh${normal} -${bold}${green} Simple Server Setup Script${normal} - Edition: ubuntu-tr/Kabuk-ShellScript"
echo "${bold}${green}Latest Relase: git clone https://github.com/BTaskaya/4S${normal}"
sleep 1

if [ "$(id -u)" != "0" ]; then
   echo "${bold}${red}Sorry! This script must be run as root.${normal}" 1>&2
   exit 1
fi

echo "${bold}${green}4S${normal} will make the ${bold}${red}necessary settings${normal} for a Server and ${bold}${red}install the basic packages.${normal}"
read -r -p "Type ${green}Y${normal} to continue or anything else to abort: " GO
if [ "$GO" != "Y" ]; then
    echo "${bold}${red}Aborting.${normal}" 1>&2
    exit 1
fi

echo "${green}APT Updates${normal} and ${green} Timezone Settings ${normal}"
apt-get update
apt-get dist-upgrade
apt-get autoremove
dpkg-reconfigure tzdata

echo "Set ${green}root ${normal} password"
passwd

read -r -p "Please enter ${green}username${normal} for new standard user: " USERNAME
if [ -z "$USERNAME" ]; then
    echo "${red}No username entered, aborting.${normal}" 1>&2
    exit 1
fi

echo "${green}Creating standard user${normal}"
useradd -s /bin/bash -d /home/$USERNAME -m -U $USERNAME
passwd $USERNAME

echo "${green} SSH Settings ${normal}"
mkdir /home/$USERNAME/.ssh
chown $USERNAME.$USERNAME /home/$USERNAME/.ssh/
cp /root/.ssh/authorized_keys /home/$USERNAME/.ssh/authorized_keys
chown $USERNAME.$USERNAME /home/$USERNAME/.ssh/authorized_keys

echo "${green}Bash${normal} Settings "
echo "PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\\$ '" >> /home/$USERNAME/.bashrc

echo "Adding ${green}$USERNAME${normal} to sudoers with ALL privileges..."
echo "$USERNAME ALL=(ALL:ALL) ALL" > /etc/sudoers.d/sysprep
chmod 0440 /etc/sudoers.d/sysprep

echo "${green} Python and Venv Installation ${normal}"
apt-get install python-setuptools
easy_install pip
pip install virtualenv virtualenvwrapper

echo "${green}Completing virtualenv${normal} config for $USERNAME"
echo "WORKON_HOME=\$HOME/.virtualenvs" >> /home/$USERNAME/.bashrc
echo "export PROJECT_HOME=\$HOME/sites" >> /home/$USERNAME/.bashrc
echo "#export VIRTUALENV_DISTRIBUTE=true" >> /home/$USERNAME/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/$USERNAME/.bashrc

echo " Adding ${green}swapfile${normal}"
dd if=/dev/zero of=/swapfile bs=1024 count=1024k
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
echo 10 | tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | tee -a /etc/sysctl.conf
chown root:root /swapfile
chmod 0600 /swapfile

echo " Setting up ${green}iptables${normal} with standard web server config"
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -P INPUT DROP
iptables -I INPUT 1 -i lo -j ACCEPT
apt-get install iptables-persistent
iptables-save > /etc/iptables/rules.v4

echo "Installing ${green}basic${normal} apt packages"
apt-get install git ntp gettext python-dev nginx mysql-server mysql-client libmysqlclient-dev memcached python-memcache htop libffi-dev libxml2-dev libxslt1-dev python-lxml fail2ban

openssl dhparam -out /etc/ssl/nginx/dhparam.pem 2048

dpkg-reconfigure --priority=low unattended-upgrades

echo " ${green}MySQL${normal} Timezone "
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql
service mysql restart

echo " * Installing ${green}Pillow${normal} dependencies..."
apt-get install libjpeg-dev libjpeg8-dev libpng3 libfreetype6-dev libwebp-dev
ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib
ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib
ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib
ln -s /usr/lib/`uname -i`-linux-gnu/libwebp.so /usr/lib
ln -s /usr/include/freetype2 /usr/local/include/freetype

echo "${green} 4S Sucsesfully Installed ${normal}Cleaning up..."
apt-get autoremove
apt-get clean

# done
echo "Done! Please reboot soon. Enjoy."
