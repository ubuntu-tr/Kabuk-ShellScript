#!/bin/bash

#----------------------------------------------------
# Özet: Yazılmış kabuk betiklerini kabuktan doğrudan 
# çağırılabilsinler diye PATH değişkeni içerisine kalıcı
# olarak ekler.
# Yazar: Fatih Eser - @afeser 
# Kaynak: https://forum.ubuntu-tr.net/...
#----------------------------------------------------

# Move to "betikler" folder
cd ..

# Global Vars
source_file="addPath/eklenecekPaths.txt"
betik_fol_loc=$(pwd)

echo $betik_fol_loc/addPath
if [ ! -f $betik_fol_loc/addPath/yolaEkle.sh ]; then
    echo "Bu betik, kendi klasörü içerisinden çağırıldığı varsayılarak yazıldı. Lütfen kendi klasörü içerisinden başlatın ve tekrar deneyin..."
    exit 1
fi

# Remove old files
rm -f $source_file &> /dev/null


# Load directories into source file
# Read "ls" output and add to the source_file
listed_files=$(ls)

echo "Yol dosyası oluşuturuluyor..."
echo "# yolaEkle.sh tarafından oluşturuldu" >> $source_file
(IFS='
'
for file in $listed_files
do 
    echo "PATH=\$PATH:$betik_fol_loc/$file" >> $source_file; 
done
)


echo ".bashrc güncelleniyor"
if grep -Fxq "source $source_file" ~/.bashrc
then
    # No need to add again
    echo ".bashrc zaten güncel"
else
    echo "# yolaEkle.sh tarafından ekleniyor" >> ~/.bashrc
    echo "source $betik_fol_loc/$source_file" >> ~/.bashrc
fi


# Set permissions
echo "İzinler ayarlanıyor..."
(IFS='
'
for folder in $listed_files
do 
    cd $folder
    chmod +x *.sh
    cd ..
done
)

echo "Bitti!"
echo "Değişiklikleri kullanabilmek için yeni bir kabuk açmanız gerekebilir"
exit 0
