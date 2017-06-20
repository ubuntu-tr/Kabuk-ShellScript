# if-then-else

```ifthenelse.sh``` isimli betik, Bash Programlamada if-then-else yapısının kullanım mantığını açıklamak için yazılmıştır.

> **Not:** Gerçek bir yedekleme programı değildir.

Kısaca kullanımı ve gerçekleştirilen işlemleri açıklayalım;

1. ifthenelse.sh dosyasını indirin ve ```chmod +x ifthenelse.sh``` komutuyla çalıştırılabilir hale getirin.
2. ```./ifthenelse.sh yedeklenecekklasor``` komutunu çalıştırın.
3. Program /tmp klasörü içine ```/tmp/yedeklenecekklasor``` isimli bir esas kaynak klasör, içine de 2 adet örnek dosya oluşturacaktır. Bunlar bizim yedeklemek istediğimiz dosyalar olacak.
4. Ardından yedeklenecek bu esas kaynak klasörü, /tmp/backups/ klasörü içine yedekleyecektir.
5. Tamamen konuyu açıklamak için, eğitim amacıyla yazılan bu betiğin oluşturduğu dosyalar, bilgisayar yeniden başlatıldığında silinir.
