# grafikbilgi.sh

Bu betik, yazılmış olan Kabuk-ShellScript deposu içerisindeki betiklerin direk olarak kabuk yardımıyla çalıştırılabilmeleri için onları PATH değişkenine ekler.

## Açıklamalar

Betiğin bulunduğu addPath klasörüne girip ```bash yolaEkle.sh``` komutunu çalıştırmanız yeterli.
Beklenmedik sonuç doğurabileceği için başka bir klasör içerisinden çalıştırılmamalıdır.

**Not :** Betik kendini .basrc içerisine ekler, ancak herhangi bir güncellemeden sonra otomatik çalışma özelliğine sahip değildir. Depo güncellemesi veya el ile değişimden sonra tekrar çağırılması gerekebilir!

## Nasıl Çalışır?

1. Betik öncelikle betikler klasörü içerisindeki tüm altklasörleri bulur ve bunları betikler/addPath/links klasörü içerisine sembolik linklerle bağlar.
2. Tüm klasörler linklendiğinde, linklerin bulunduğu klasörü ~/.bashrc içerisine ekler.
3. Tüm klasörlerin altındaki her bir *.sh dosyası için çalıştırma izni verir.


