#!/bin/bash

#----------------------------------------------------
# Özet: Bu betik, /home klasörüne oluşturacağınız iplist isimli dosyada bulunan iplere sırayla ping sinyalleri göndererek 
# ip adreslerinin açık olup olmadığını kontrol eder.
# Yazar: @siberoloji
#----------------------------------------------------

FILE=$HOME/iplist
#
#

if [ -n "$1" ]; then
ping -q -c2 $1 &> /dev/null

else
if [ -f $FILE ];
then
for i in $( cat $FILE )
do
ping -q -c2 $i > /dev/null

if [ $? -eq 0 ] 
then
echo $i "Is_Pingable"
else
echo $i "Not_Pingable"
fi
done
exit 0

else
ping -q -c3 google.com > /dev/null
# <--- ping -q -c2 localhost > /dev/null
fi
fi

if [ $? -eq 0 ] 
then
if [ -n "$1" ]; 
then
echo $1 Host_Found
else
echo "Google_Found"
fi

else
if [ -n "$1" ]; 
then
echo $1 Host_not_Found
else
echo "Google_not_Found"
fi
fi
