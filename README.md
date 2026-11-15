# BilgiKutusu Go

**BilgiKutusu ailesinin en düşük seviyeli, temel başlangıç paketi.**

Raspberry Pi üzerindeki dosyalarına aynı yerel ağa bağlı telefon veya bilgisayardan ulaş. Önceden kaydettiğin içerikleri açmak için internet gerekmez; cihazla yerel ağ bağlantısı gerekir.

## Neler yapar?

- Klasörlerde gezinme ve açık klasörde ada göre filtreleme.
- Dosya açma ve indirme.
- Türkçe, telefon ekranına uyumlu arayüz.
- İsteğe bağlı otomatik başlatma ve Wi-Fi profil hazırlama.

Yapay zekâ ve hazır kitap, film, harita veya Wikipedia koleksiyonu içermez. Go, en temel pakettir; Plus orta, Pro üst pakettir.

## Hızlı başlangıç

Python 3.9 veya yenisi bulunan Linux/Raspberry Pi cihazında, bu klasörde terminal aç:

```bash
bash baslat.sh
```

Aynı cihazın tarayıcısında **http://127.0.0.1:8090** adresini aç. Durdurmak için `Ctrl+C` kullan.

Pi her açıldığında çalışması ve aynı ağdaki telefondan erişim için:

```bash
sudo bash kurulum/kur.sh
```

Kurulumdan sonra `hostname -I` ile Pi'nin adresini öğren; telefonda `http://PI_IP_ADRESI:8090` adresini aç. Kurucu ayrı Go klasörleri kullanır; mevcut BilgiKutusu dosyalarını ve ağ ayarlarını değiştirmez.

## Düzenli klasör yapısı

| Dosya / klasör | İçeriği |
| --- | --- |
| `baslat.sh` | Kurmadan hızlı deneme |
| `uygulama/` | Python kodu ve web arayüzü |
| `ayarlar/` | Yerel deneme ayarları |
| `icerik/` | Örnek klasörler; kendi dosyaların için alan |
| `kurulum/` | Kurma, güncelleme, durum, kaldırma ve Wi-Fi araçları |
| `belgeler/` | Kullanım kılavuzları ve TXT açıklamalar |
| `testler/` | Otomatik testler |
| `LICENSE` | Lisansın tam metni |

**Rehberler:** [İlk adımlar](belgeler/BASLA.txt) · [Kurulum](belgeler/KURULUM.md) · [Ayrıntılı kullanım](belgeler/KULLANIM.md) · [Wi-Fi](belgeler/WIFI.md)

## Test durumu

```bash
python3 -m unittest discover -s testler -v
```

Dosya erişimi testleri başarılıdır. Raspberry Pi/Wi-Fi ve görsel tarayıcı denemesi henüz yapılmamıştır. [Test ayrıntıları](belgeler/TESTLER.md).

## Gizlilik

Pakette API anahtarı veya hazır şifre yoktur. Ad-soyad lisans ve geliştirici bildirimi için korunur. [Gizlilik ayrıntıları](belgeler/GIZLILIK.md).

## Lisans ve katkı

Kişisel ve eğitim amaçlı kullanım ücretsizdir. Ticari kullanım için önceden yazılı izin gerekir. [Lisans](LICENSE) · [Katkı koşulları](belgeler/KATKI.md).

Ticari kullanım kısıtlaması nedeniyle OSI tanımına uygun bir açık kaynak lisansı değildir. Güvenilir yerel ağda kullanım içindir; kullanıcı hesabı veya HTTPS sağlamaz.

**Ali Can Yılmaz** · Sürüm 1.0.0  
Telif hakkı © 2026 Ali Can Yılmaz. Tüm hakları saklıdır.
