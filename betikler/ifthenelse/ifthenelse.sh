#!/bin/bash

#----------------------------------------------------
# Özet: Bu betik, if, then, it-then-else yapısının çalışma mantığını açıklamak için yazılmıştır. 
# Konunun anlaşılması için /tmp klasörü içinde otomatik olarak bir klasör ve örnek 2 adet dosya oluşturulmaktadır.
# Uyarı: Kodlar bu haliyle eğitim amacıyla kullanılabilir. Gerçek yedekleme programı değildir.
# Yazar: @siberoloji
# Kaynak: https://siberoloji.github.io/linux-ile-bash-script-temelleri/
#----------------------------------------------------

if [ $# != 1 ]
then
clear
echo Kullanım: Yedeklenecek klasörü belirten 1 tek klasör adı girmelisiniz.
exit
fi

if [ ! -d /tmp/$1 ]
then
clear
echo 'Adını verdiğiniz klasör bulunmuyor. Yeni klasör ve içeriği oluşturulacak'
mkdir /tmp/$1&&touch /tmp/$1/dosya1.txt /tmp/$1/dosya2.txt
echo /tmp Klasörüne $1 Klasörü ve içeriği oluşturuldu.
sleep 5
fi

echo ---------------------------
date=`date +%F`

# Bugün yedeği alınmış başka bir klasör var mı diye bakıyoruz?

if [ -d /tmp/backups/$1_$date ]
then
echo 'Bu klasörün bugün yedeği alınmış. Yine de üstüne yazılsın mı?'
read answer
    if [ $answer != 'y' ]
    then
    exit
    fi
else
mkdir -p /tmp/backups/$1_$date
echo /tmp Klasörüne /backup klasörü ve $1_$date Klasörü oluşturuldu.
sleep 5
fi

cp -R /tmp/$1 /tmp/backups/$1_$date
echo /tmp klasöründe bulunan $1 klasör içeriği /tmp/backups/$1_$date klasörüne yedeklendi.
sleep 5

echo Yedekleme tamamlandı.
echo isterseniz /tmp/$1 klasörünü ve
echo /tmp/backups/$1_$date klasörünü silebilirsiniz.
echo /tmp klasörü sisteminizi kapattığınızda kendisi zaten silinir.
sleep 1

echo ESAS KLASÖR İÇERİĞİ
ls -l /tmp/$1
sleep 1

echo YEDEKLENEN KLASÖR İÇERİĞİ
ls -l /tmp/backups/$1_$date/$1/
echo Script sona erdi…
