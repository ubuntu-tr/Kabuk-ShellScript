#!/bin/bash

#-----------------------------------------------------------------------------------------------------------------------------
#        ubuntu-sys System Management Scripts for Ubuntu*
#		Copyright (C) 2020  Mert Gör
#
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU Affero General Public License as
#        published by the Free Software Foundation, either version 3 of the
#        License, or (at your option) any later version.
#
#        This program is distributed in the hope that it will be useful,
#        but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#        GNU Affero General Public License for more details.
#
#        You should have received a copy of the GNU Affero General Public License
#        along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#        For questions, bug reports and feedback please send an e-mail to mertgor at masscollabs dot com

# Özet: ubuntu-sys System Management Scripts for Ubuntu* for system update, system upgrade, and application, framework and compiler installation for developers, sysadmins, and end users  
# Yazar: @hwpplayer1
# Kaynak: https://github.com/hwpplayers/Kabuk-ShellScript

#Bu dizin içerisinde Ubuntu ve türevi sistemlerin kurulumundan sonra yapılması iyi olacak komutları bir bash betiği haline getirmeye çalışacağım. 
#*system-management* dizini içerisinde tek tek scripler bulunacaktır. UNIX felsefesine uygun olduğunu düşündüğüm üslupta, sadelik ve tek iş yap tek işi iyi yap anlayışı içerisinde aşağıdaki betikler bu dizinde yer alacaktır. 
#------------------------------------------------------------------------------------------------------------------------------------------

id="$(lsb_release -i)"
ubuntu="Ubuntu"
if echo "$id" | grep -q "$ubuntu";
then
    echo "Ubuntu";
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get auto-remove -y
    sudo apt-get clean
else
    echo "Other UNIX system or Windows Subsystem for Linux";
    echo $(uname -a)
fi
