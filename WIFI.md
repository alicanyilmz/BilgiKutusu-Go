# İsteğe bağlı kendi Wi-Fi ağı

**Mevcut BilgiKutusu Wi-Fi ağına zaten bağlanabiliyorsan bu adım gerekli değildir.** Go'yu aynı ağdaki Pi IP adresinin 8090 portundan açabilirsin.

Go uygulaması ağ ayarlarını kendiliğinden değiştirmez. Bu araç yalnızca NetworkManager kullanan Linux sistemler içindir. Başka bir ağ yöneticisini değiştirmez veya kaldırmaz.

## Profil hazırla

Önce aygıt adını gör:

```bash
nmcli device status
```

AP destekli aygıtın örneğin `wlan1` ise:

```bash
sudo python3 scripts/prepare_wifi.py wlan1
```

Kendi şifreni iki kez yaz. Şifre ekrana basılmaz, kodun içine konmaz ve komut satırı argümanlarında taşınmaz. Profil, yalnızca root tarafından okunabilen NetworkManager dosyasına kaydedilir.

- Wi-Fi adı: **BilgiKutusu-Go**
- WPA2-PSK şifreleme; rastgele, güçlü ve başka yerde kullanmadığın bir şifre seç.
- Adres: **10.43.0.1/24**
- Profil hazırlama, ağı etkinleştirmez; otomatik başlatma kapalıdır.
- Mevcut profil adı veya çakışan IPv4 ağı varsa araç durur.

## Etkinleştirme

**Bu komut seçilen Wi-Fi aygıtının mevcut bağlantısını değiştirir.** Aynı aygıt üzerinden SSH kullanıyorsan bağlantın kesilebilir. Pi'ye bağlı klavye/ekran veya başka bir ağ bağlantısı üzerinden çalıştır:

```bash
sudo nmcli connection up BilgiKutusu-Go
```

Telefonu **BilgiKutusu-Go** ağına bağla. Telefon “internet yok” derse bu ağda kalmayı seç. Go hizmeti çalışıyorsa şu adresi aç:

**http://10.43.0.1:8090**

Ağ açılmazsa `sudo journalctl -u NetworkManager -n 50 --no-pager` çıktısını kontrol et. Paylaşımlı ağ modu için sistemin DHCP/DNS bileşenleri, örneğin dnsmasq, gerekli olabilir. Sürücü/AP desteği Raspberry Pi üzerinde ayrıca doğrulanmalıdır.

NetworkManager'ın `shared` modu istemcilere adres dağıtır; Pi'nin başka bir internet bağlantısı varsa onu paylaşabilir. Yerel dosya erişimi internet olmadan da çalışır. Bu araç captive portal veya giriş ekranı oluşturmaz.

Başarıyla denedikten sonra her açılışta aynı AP'nin başlamasını istersen:

```bash
sudo nmcli connection modify BilgiKutusu-Go connection.autoconnect yes
```

## Kapatma ve önceki ağa dönüş

```bash
sudo nmcli connection modify BilgiKutusu-Go connection.autoconnect no
sudo nmcli connection down BilgiKutusu-Go
nmcli connection show
```

Son listedeki önceki bağlantının adını kullanarak `sudo nmcli connection up "ÖNCEKİ_BAĞLANTI_ADI"` komutunu çalıştır. Ağ profili silinmez. Go'yu kaldırma komutu da bu Wi-Fi profiline dokunmaz.
