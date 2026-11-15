# Paylaşılacak pakette gizlilik

- Geliştirici adı ve lisans bildirimi korunur.
- Dağıtım paketinde gerçek API anahtarı, erişim tokenı, Wi-Fi şifresi veya özel anahtar bulunmaz. Uygulama dış API anahtarı gerektirmez.
- `127.0.0.1` yerel deneme, `0.0.0.0` dinleme ayarı ve `10.43.0.0/24` isteğe bağlı Go ağı için varsayılan teknik değerlerdir; bir kullanıcının mevcut ağından alınmamıştır.
- `/api/list` ve `/api/health`, aynı cihazdaki uygulamanın yerel çalışma yollarıdır; API anahtarı değildir.
- Wi-Fi şifresi profil hazırlanırken kullanıcıdan alınır. Cihazdaki NetworkManager klasörüne, proje klasörünün dışında ve yalnızca root tarafından okunacak izinlerle yazılır; bu ZIP'e eklenmez.
- Uygulama erişim kayıtlarına istemci IP'si, istek başlığı, URL veya dosya adı yazmaz. Beklenmeyen bağlantı hatalarında ayrıntılı istek dökümü basılmaz.
- `.env`, özel anahtar, yerel ayar ve ağ profili gibi dosyalar için Git dışlama kuralları eklenmiştir. Örnek başlangıç belgesi dışında kişisel içerik paketlenmemiştir.

Bu kontrol teslim edilen paketi kapsar. Sonradan eklenen dosyalar ayrıca kontrol edilmelidir. `.gitignore`, GitHub'ın web arayüzünden elle seçilen yüklemeleri veya daha önce izlemeye alınmış dosyaları engellemez. Yükleme listesine özel dosya ve ağ profili ekleme.

Uygulamadaki durum komutu, bağlantı kurabilmen için IP adresini yerel terminalde gösterebilir. Bu çıktı ZIP'e kaydedilmez veya dışarı gönderilmez.
