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
betik_fol_loc=$(pwd)

if [ ! -f $betik_fol_loc/addPath/yolaEkle.sh ]; then
    echo "Bu betik, kendi klasörü içerisinden çağırıldığı varsayılarak yazıldı. Lütfen kendi klasörü içerisinden başlatın ve tekrar deneyin..."
    exit 1
fi

# Remove old files
rm -rf $betik_fol_loc/addPath/links

# Create new files
mkdir addPath/links &> /dev/null

# Read "ls" output and create new links into directory links
listed_files=$(ls)

echo "Yeni linkler oluşturuluyor..."
(IFS='
'
for folder in $listed_files
do 
    ln -s $betik_fol_loc/$folder/*.sh $betik_fol_loc/addPath/links/
done
)

echo "~/.bashrc güncelleniyor..."
if grep -Fxq "PATH=\$PATH:$betik_fol_loc/addPath/links" ~/.bashrc
then
    # No need to add again
    echo "~/.bashrc zaten güncel!"
else
    echo "# yolaEkle.sh tarafından ekleniyor" >> ~/.bashrc
    echo "PATH=\$PATH:$betik_fol_loc/addPath/links" >> ~/.bashrc
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
