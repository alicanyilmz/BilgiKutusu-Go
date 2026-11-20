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
sudo bash install/kur.sh
```

Kurulumdan sonra `hostname -I` ile Pi'nin adresini öğren; telefonda `http://PI_IP_ADRESI:8090` adresini aç. Kurucu ayrı Go klasörleri kullanır; mevcut BilgiKutusu dosyalarını ve ağ ayarlarını değiştirmez.

## Düzenli klasör yapısı

| Dosya / klasör | İçeriği |
| --- | --- |
| `baslat.sh` | Kurmadan hızlı deneme |
| `app/` | Python kodu ve web arayüzü |
| `config/` | Yerel deneme ayarları |
| `content/` | Örnek klasörler; kendi dosyaların için alan |
| `install/` | Kurma, güncelleme, durum, kaldırma ve Wi-Fi araçları |
| `docs/` | Kullanım kılavuzları ve TXT açıklamalar |
| `tests/` | Otomatik testler |
| `LICENSE` | Lisansın tam metni |

**Rehberler:** [İlk adımlar](BASLA.txt) · [Kurulum](KURULUM.md) · [Ayrıntılı kullanım](KULLANIM.md) · [Wi-Fi](WIFI.md)

## Test durumu

```bash
python3 -m unittest discover -s tests -v
```

Dosya erişimi testleri başarılıdır. Raspberry Pi/Wi-Fi ve görsel tarayıcı denemesi henüz yapılmamıştır. [Test ayrıntıları](TESTLER.md).

## Gizlilik

Pakette API anahtarı veya hazır şifre yoktur. Ad-soyad lisans ve geliştirici bildirimi için korunur. [Gizlilik ayrıntıları](GIZLILIK.md).

## Lisans ve katkı

MIT lisansı ile yayımlanır. Lisans ve telif hakkı bildirimi korunarak ticari kullanım, değiştirme ve dağıtıma izin verilir. [Lisans](../LICENSE) · [Katkı koşulları](KATKI.md).

Güvenilir yerel ağda kullanım içindir; kullanıcı hesabı veya HTTPS sağlamaz.

**alicanyilmz** · Sürüm 1.0.0  
Telif hakkı © 2026 alicanyilmz.
