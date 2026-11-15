# Kurulum ve kullanım

## 1. Kurmadan dene

ZIP'i çıkar ve `BilgiKutusu-Go` klasöründe terminal aç:

```bash
python3 --version
python3 uygulama/app.py --check
bash baslat.sh
```

Tarayıcı adresi: `http://127.0.0.1:8090`. Örnek belge `Belgeler` klasöründedir.

Telefonla denemek için `ayarlar/config.json` içindeki `host` değerini `0.0.0.0` yap ve uygulamayı yeniden başlat. Telefon Pi ile aynı ağda olmalıdır. `hostname -I` çıktısından o ağa ait adresi seç; `http://ADRES:8090` biçiminde aç.

## 2. Otomatik başlama kur

Deneme uygulamasını `Ctrl+C` ile durdurduktan sonra:

```bash
sudo bash kurulum/kur.sh
```

Kurucu paket indirmez. Python yoksa önce `sudo apt update` ve `sudo apt install python3` ile yükleyebilirsin; bu işlem internet gerektirir. Kurulum sonrasında Go'nun çalışması için internet gerekmez.

Kurucu `/opt/bilgikutusu-go`, `/etc/bilgikutusu-go` ve `/srv/bilgikutusu-go` yollarını kullanır; var olan yolların üzerine yazmaz. Yeni, oturum açamayan `bilgikutusu-go` hizmet kullanıcısı oluşturur. Hizmet root olarak çalışmaz.

Kurulumun bir kısmı hata verdiyse tekrar tekrar çalıştırma; mesajdaki yolu ve `journalctl` çıktısını incele. Kurucu otomatik veri silme yapmaz.

## 3. İçerik ekle

Dosyaları `/srv/bilgikutusu-go/icerik` altına koy. Alt klasörler 0755, paylaşılacak dosyalar 0644 gibi hizmet kullanıcısının okuyabileceği izinlere sahip olmalıdır. Yalnızca paylaşım için ayırdığın dosyaların izinlerini değiştir.

```bash
sudo install -m 0644 "$HOME/Downloads/ornek.pdf" /srv/bilgikutusu-go/icerik/Belgeler/
```

Tarayıcıda **Yenile** düğmesine bas. Yeni dosya için hizmeti yeniden başlatmak gerekmez. Klasör başına 2.000 içerik sınırına ulaşırsan alt klasörler kullan.

## 4. SSD'de ayrı Go klasörü kullanmak

Bu örnekte disk `/mnt/depo` noktasına bağlı kabul edilir; kendi diskine uygun yolu kullan. Go için ayrı bir alt klasör ayır. Önce `findmnt /mnt/depo` ile diskin gerçekten bağlı olduğunu kontrol et. Disk bağlı değilse devam etme.

```bash
mkdir -p /mnt/depo/Go/Belgeler
sudo nano /etc/bilgikutusu-go/config.json
```

`content_dir` değerini `/mnt/depo/Go` yap. Go mevcut dosyaları taşımaz, silmez veya diski biçimlendirmez. exFAT izinleri bağlama seçenekleriyle belirlenir; kurucu fstab dosyasını değiştirmez.

Hizmetin diski beklemesini sağlamak için:

```bash
sudo systemctl edit bilgikutusu-go
```

Aşağıdakini ekle:

```ini
[Unit]
RequiresMountsFor=/mnt/depo
ConditionPathIsMountPoint=/mnt/depo
```

Sonra okuma iznini denetle ve yeniden başlat:

```bash
sudo -u bilgikutusu-go python3 /opt/bilgikutusu-go/app.py --config /etc/bilgikutusu-go/config.json --check
sudo systemctl daemon-reload
sudo systemctl restart bilgikutusu-go
```

## 5. Durum, ayarlar ve sorun giderme

```bash
bash kurulum/durum.sh
sudo journalctl -u bilgikutusu-go -n 30 --no-pager
```

| Durum | Kontrol |
| --- | --- |
| Telefonda açılmıyor | Aynı ağ, doğru Pi IP adresi ve `:8090` portunu kontrol et. VPN veya telefonun mobil verisi farklı yola yönlendirebilir. |
| Pi'de açılıyor, telefonda açılmıyor | `host` değeri `0.0.0.0` olmalı; yerel güvenlik duvarı ve AP istemci yalıtımını kontrol et. Kurucu güvenlik duvarını değiştirmez. |
| İzin hatası | Hizmet kullanıcısının bütün üst klasörlere geçiş ve dosyaya okuma iznini denetle. |
| Port kullanımda | Diğer hizmeti kapatmak yerine Go için boş bir port seç. Manuel deneme de portu tutuyor olabilir. |
| PDF/video açılmıyor | İndirip uyumlu bir uygulamayla dene. Dosya biçimi ve kod çözücü tarayıcıya bağlıdır. |

Kurulu ayarlar `/etc/bilgikutusu-go/config.json` içindedir. `host`, `port`, `content_dir`, `max_clients` ve `max_entries` değerleri desteklenir. Ayar değişikliğinden sonra hizmeti yeniden başlat. Bu sürüm IPv4 dinleme adresleri için hazırlanmıştır.

## 6. Kaldırma

```bash
sudo bash kurulum/kaldir.sh
```

Bu komut Go uygulama kodunu ve hizmet tanımını kaldırır. İçerik, ayarlar, hizmet kullanıcısı ve Wi-Fi profilleri korunur. Yeniden kurulum için `sudo bash kurulum/guncelle.sh` kullanılabilir; bu komut korunmuş ayar ve içerikleri kullanır.

## 7. Güncelleme veya korunmuş kurulumu geri yükleme

Yeni paketin klasöründe:

```bash
sudo bash kurulum/guncelle.sh
```

Uygulama kodu ve hizmet tanımı güncellenir; ayarlar ve içerik korunur. Eski kod varsa `/var/backups` altında yedeklenir. Kurulum ve güncelleme komutlarını yalnızca güvendiğin kaynak koduyla çalıştır.
