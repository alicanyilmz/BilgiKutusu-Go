<div align="center">

# BilgiKutusu Go

**İnternet olmasa da dosyalarına ulaş.**

Raspberry Pi tabanlı, sade ve taşınabilir çevrimdışı bilgi deposu.

[![Platform](https://img.shields.io/badge/Platform-Raspberry%20Pi-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)
[![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Belgeler](https://img.shields.io/badge/Belgeler-Türkçe-blue)](docs/KULLANIM.md)

</div>

---

## Proje hakkında

**BilgiKutusu Go**, Raspberry Pi üzerindeki dosyalara aynı yerel ağa bağlı telefon, tablet ve bilgisayarlardan erişim sağlayan temel bilgi deposudur. Önceden kaydedilmiş içerikleri açmak için internet gerekmez.

Go başlangıç, Plus orta, Pro üst pakettir. Go yapay zekâ, hazır kitap, film, harita veya Wikipedia koleksiyonu içermez.

> Proje geliştirme aşamasındadır. Raspberry Pi donanımı ve Wi-Fi üzerinde ayrıca deneme gerekir.

## Mimari

| Katman | Teknoloji | Görev |
|---|---|---|
| Cihaz | Raspberry Pi / Linux | Yerel dosya paylaşımı |
| Uygulama | Python 3.9+ standart kütüphanesi | Dosya listeleme ve sunma |
| Arayüz | HTML, CSS ve JavaScript | Telefon ve bilgisayardan kullanım |
| Ayarlar | JSON | Adres, port ve içerik klasörü |
| Otomatik başlatma | systemd | İsteğe bağlı hizmet kurulumu |

## Özellikler

- Klasörlerde gezinme ve açık klasörde dosya adına göre filtreleme.
- Dosyaları açma ve indirme.
- Türkçe, telefon ekranına uyumlu arayüz.
- İnternet, dış API veya ek Python paketi gerektirmeyen çalışma.
- İsteğe bağlı otomatik başlatma ve Wi-Fi profil hazırlama.

Wi-Fi profili hazırlama aracı mevcut bağlantıyı otomatik değiştirmez. Kullanım için cihazlar arasında yerel ağ bağlantısı gerekir.

## Hızlı başlangıç

Depo ana klasöründe:

```bash
bash baslat.sh
```

Aynı cihazda **http://127.0.0.1:8090** adresini aç. Durdurmak için `Ctrl+C` kullan.

Otomatik başlatma ve yerel ağ erişimi için önce [kurulum rehberini](docs/KURULUM.md) oku:

```bash
sudo bash install/kur.sh
```

Kurulumdan sonra `hostname -I` ile Pi adresini öğren; aynı ağdaki telefonda `http://PI_IP_ADRESI:8090` adresini aç.

## Klasör düzeni

| Konum | İçerik |
|---|---|
| [app/](app/) | Python uygulaması ve web arayüzü |
| [config/](config/) | Yerel deneme ayarları |
| [content/](content/) | Örnek içerik ve kendi dosyaların |
| [install/](install/) | Kurulum, güncelleme, durum ve Wi-Fi araçları |
| [docs/](docs/) | Donanım, kurulum ve kullanım belgeleri |
| [tests/](tests/) | Otomatik testler |
| `baslat.sh` | Kurmadan hızlı deneme |

## Donanım ve belgeler

[Donanım](docs/DONANIM.md) · [İlk adımlar](docs/BASLA.txt) · [Kurulum](docs/KURULUM.md) · [Kullanım](docs/KULLANIM.md) · [Wi-Fi](docs/WIFI.md)

## Testler

```bash
python3 -m unittest discover -s tests -v
```

Testler geçici içeriklerle gerçek HTTP isteklerini denetler. Donanım performansı, Wi-Fi ve systemd kurulumu için cihaz üzerinde ayrıca test gerekir. [Test kapsamı](docs/TESTLER.md).

## Gizlilik

API anahtarı veya hazır şifre içermez. Kullanıcı hesabı ve HTTPS sağlamaz; güvenilir yerel ağda kullanım içindir. [Gizlilik belgesi](docs/GIZLILIK.md).

## Lisans ve katkı

Kişisel ve eğitim amaçlı kullanım ücretsizdir. Ticari kullanım için önceden yazılı izin gerekir. Ticari kullanım kısıtlaması nedeniyle OSI tanımına uygun bir açık kaynak lisansı değildir.

[Lisans](LICENSE) · [Katkı koşulları](docs/KATKI.md)

**Ali Can Yılmaz** · Sürüm 1.0.0  
Telif hakkı © 2026 Ali Can Yılmaz. Tüm hakları saklıdır.
