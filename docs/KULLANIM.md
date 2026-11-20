# BilgiKutusu Go

**BilgiKutusu ailesinin en düşük seviyeli, temel başlangıç paketi.**

BilgiKutusu Go, Raspberry Pi üzerindeki dosyaları aynı yerel ağa bağlı telefon ve bilgisayarlara sunan sade bir bilgi deposudur. Cihazda önceden saklanan içeriklere internet olmadan erişilebilir. Telefon ile Raspberry Pi arasındaki Wi-Fi veya yerel ağ bağlantısı gereklidir.

**Sürüm:** 1.0.0 · **Geliştirici:** Ali Can Yılmaz

## Bu pakette neler var?

- Türkçe, telefon ve bilgisayara uyumlu dosya arayüzü.
- Klasörlerde gezinme ve açık klasörde dosya adına göre filtreleme.
- Belge, görsel ve diğer dosyaları açma veya indirme.
- Tarayıcının desteklediği ses ve video dosyalarında aralık istekleri.
- Python standart kütüphanesiyle çalışma; pip paketi, CDN veya dış API gerekmez.
- Linux için otomatik başlatma hizmeti, kurulum ve durum denetimi.
- İsteğe bağlı, mevcut ağı hemen değiştirmeyen Wi-Fi profil hazırlama aracı.
- Örnek başlangıç belgesi, lisans ve testler.

Go'da yapay zekâ, hazır Wikipedia arşivi, hazır film/kitap koleksiyonu, ayrıntılı haritalar, web üzerinden yükleme veya silme ve kullanıcı hesabı sistemi bulunmaz. Kendi içeriklerini cihaza kopyalarsın. İnternetten içerik indirme veya internet bağlantısı sağlama bu uygulamanın görevi değildir.

## Paketler

| Paket | Seviye |
| --- | --- |
| **Go** | **En düşük seviye — temel başlangıç** |
| Plus | Orta paket |
| Pro | Üst paket |

Bu depo yalnızca Go kodlarını içerir. Plus ve Pro'nun özellikleri Go'ya dahil değildir.

## Gereksinimler

- Raspberry Pi üzerinde Linux: Raspberry Pi OS veya Debian tabanlı bir sistem hedeflenir.
- Python 3.9 veya yenisi; otomatik kurulum için systemd ve yönetici yetkisi.
- Kendi içeriklerine yetecek boş alan. 1 TB SSD zorunlu değildir.
- Telefon veya bilgisayarda güncel bir web tarayıcısı.
- Kendi Wi-Fi ağını oluşturmak istersen AP destekli Wi-Fi aygıtı ve NetworkManager.

Donanım üzerinde RAM/performans ölçümü yapılmadı. Varsayılan sınır 8 eşzamanlı HTTP bağlantısı ve klasör başına 2.000 görünür içeriktir; bu bir cihaz sayısı garantisi değildir.

## Hızlı deneme — kurmadan

ZIP'i çıkar, `BilgiKutusu-Go` klasöründe terminal aç:

```bash
bash baslat.sh
```

Aynı cihazın tarayıcısında **http://127.0.0.1:8090** adresini aç. Durdurmak için `Ctrl+C` kullan. Varsayılan deneme ayarı yalnızca bu cihazdan erişime açıktır.

## Raspberry Pi'ye kurulum

Mevcut BilgiKutusu içeriklerini silmeden, ayrı bir Go kurulumu yapar:

```bash
sudo bash install/kur.sh
```

Kurulumdan sonra aynı ağdaki telefonda `http://PI_IP_ADRESI:8090` adresini aç. Pi adresini öğren:

```bash
hostname -I
```

`PI_IP_ADRESI` yerine o an bağlı olduğun ağdaki gerçek Pi IP adresini yaz. Mevcut diğer hizmetler, Wi-Fi profilleri ve içerikler değiştirilmez. Kurucu mevcut bir Go kurulumu veya dolu 8090 portu bulursa durur.

**Ayrıntılar:** [Kurulum ve içerik ekleme](KURULUM.md) · [İsteğe bağlı Wi-Fi](WIFI.md)

## Dosya ekleme

Kurulan sürümün içerik klasörü:

```text
/srv/bilgikutusu-go/icerik/
  Belgeler/
  Kitaplar/
  Gorseller/
```

Örnek bir PDF kopyalama komutu:

```bash
sudo install -m 0644 "$HOME/Downloads/kitap.pdf" /srv/bilgikutusu-go/icerik/Kitaplar/
```

Kaynak dosya yolunu kendi dosyana göre değiştir. Sonra web sayfasında **Yenile** düğmesine bas. Kodları GitHub'a yüklemek kişisel içeriklerini oraya yüklemeni gerektirmez.

## Çalışma sınırları

- Uygulama yalnızca okuma sunar; erişebilen herkes paylaşılan dosyaları okuyabilir. Yalnızca paylaşmak istediğin dosyaları içerik klasörüne koy.
- Güvendiğin yerel ağda kullan. Uygulama HTTPS veya kullanıcı kimlik doğrulaması sağlamaz; modemden port yönlendirmesiyle internete açmak için tasarlanmamıştır.
- Arama dosyanın içeriğinde veya bütün alt klasörlerde yapılmaz; açık klasördeki adları filtreler.
- Tarayıcıya uygun PDF, metin, görsel ve medya dosyaları açılır. Desteklenmeyen biçimler indirilir; tarayıcı desteği değişebilir.
- HTML, SVG ve tanınmayan dosyalar etkin içerik çalıştırmamak için indirmeye yönlendirilir.
- Gizli dosyalar, sembolik bağlantılar ve içerik klasörünün dışı paylaşılmaz.
- Harici diski ayarlamadan önce bağlama ve okuma izinlerini kontrol et; ayrıntılar kurulum kılavuzundadır.

## Testler

```bash
python3 -m unittest discover -s tests -v
```

Testler geçici klasörler ve gerçek HTTP istekleri kullanır. Raspberry Pi donanımı, Wi-Fi sürücüsü ve systemd kurulumu için ayrıca cihaz üzerinde deneme gerekir. Test kapsamı [docs/TESTLER.md](TESTLER.md) dosyasındadır.

## Lisans ve katkılar

Proje **BilgiKutusu Go – Ücretsiz ve Ticari Olmayan Kullanım Lisansı** ile sunulur. Kişisel ve eğitim amaçlı kullanım ücretsizdir. Ticari kullanım için önceden yazılı izin gerekir. Tam metin: [LICENSE](../LICENSE).

Ticari kullanım kısıtlaması nedeniyle bu lisans OSI açık kaynak tanımına uygun değildir. Kaynak kodu görüntülenebilir ve lisans koşullarıyla kullanılabilir. Üçüncü taraf içerikler kendi lisanslarına tabidir.

Katkı için [docs/KATKI.md](KATKI.md) dosyasını oku.

Telif hakkı © 2026 Ali Can Yılmaz. Tüm hakları saklıdır.
