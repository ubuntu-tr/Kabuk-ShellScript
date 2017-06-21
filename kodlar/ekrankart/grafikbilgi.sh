#!/bin/bash

#----------------------------------------------------
# Özet: Bu betik, Eran kartı problemi olan Ubuntu kullanıcıarının donanım 
# bilgisini özetlemek için yazılmıştır. Bir problem yaşadığınızda, çözüme
# yardımcı olunabilmesi için, bu betiğin çıktılarının paylaşılması
# faydalı olacaktır.
# Yazar: @siberoloji
# Tarih: 21 June 2017
# Licence: MIT License 
#----------------------------------------------------
clear

# msa-utils kontrol----------------------------
echo "mesa-utils kontrolü yapılıyor..."
sleep 1

if ! which glxinfo &>/dev/null; then 
	echo "Sisteminizde mesa-utils kurulu olması gerek."
	sleep 3
	echo "Kuruluyor..."
	sleep 2
	sudo apt-get install -y mesa-utils
	sleep 3
else
	
	echo "Sisteminizde mesa-utils kurulu durumda."
	sleep 1
	echo "Sonraki adıma geçiliyor..."

fi

clear

# lsb_release -a bilgileri-----------------------
echo Aşağıda yer alan bilgileri paylaşabilirsiniz.
sleep 3
echo "----------------------------------------"
echo "Dağıtım bilgileri."
echo "----------------------------------------"
lsb_release -a
sleep 1

# lspci -nnk bilgileri---------------------------
echo "----------------------------------------"
echo "PCI cihaz bilgileri."
echo -----------------------------------------
lspci -nnk | egrep "VGA|3D|Display" -A2
sleep 1

# glxinfo | grep render bilgileri-
echo "----------------------------------------"
echo "glxinfo bilgileri."
echo -----------------------------------------
glxinfo | grep render
sleep 1

# xrandr bilgileri----------------
echo "----------------------------------------"
echo "xrandr bilgileri."
echo ----------------------------------------
xrandr
sleep 1

# Ekran Kartı Sürücü bilgileri----
echo "----------------------------------------"
echo "Ekran Kartı Sürücü bilgileri."
echo ----------------------------------------
dpkg -l | egrep "nvidia|bumblebee|nvidia-prime|fglrx"
sleep 1

echo ---------------bitti---------------------
echo "Yukarıda özetlenen bilgileri problem çözümü için paylaşabilirsiniz."
sleep 5
