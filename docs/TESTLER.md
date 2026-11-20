# Doğrulama durumu — 16 Kasım 2026

## Tamamlanan kontroller

Python 3.12.14 ortamında `python3 -m unittest discover -s tests -v` ile **19 test başarılı**:

- Ana sayfa ve yerel CSS/JavaScript/SVG dosyalarının HTTP yanıtları.
- Sağlık denetimi, klasör gezinme, boş klasör ve olmayan dosya.
- Türkçe ve boşluk içeren dosya adlarının indirilmesi.
- Gizli dosyaların, sembolik bağlantıların ve klasör dışına çıkma yollarının engellenmesi.
- HTML/SVG içeriklerinin indirmeye yönlendirilmesi.
- Tam, kısmi ve sondan dosya okuma; hatalı aralık ve boş dosya.
- HEAD isteği, yükleme/silme işlemlerinin kapalı olması.
- Kalabalık klasör sınırı ve göreli ayar yolu.

Ek olarak `node --check app/web/app.js`, Python derleme kontrolü, Bash sözdizimi denetimi, `bash baslat.sh --check` ve `systemd-analyze verify` kontrolleri geçti.

## Tamamlanmayan kontroller

- Gerçek tarayıcıda görsel ve etkileşim testi: Chromium, bu ortamda gerekli soketi açamadığı için başlatılamadı. Telefon görünümü, indirme tıklaması ve arama etkileşiminin tarayıcıda geçtiği iddia edilmemektedir.
- Raspberry Pi üzerinde kurulum, yeniden başlatma ve kaldırma.
- Fiziksel Wi-Fi aygıtı ile erişim noktası ve DHCP denemesi.
- Harici SSD bağlama ve exFAT okuma izinleri.
- Gerçek cihazda RAM/CPU, hız ve eşzamanlı kullanıcı ölçümü.

Bu paket bir başlangıç sürümüdür; yukarıdaki donanım denemeleri yapılmadan kurulumun her cihazda sorunsuz olduğu söylenemez.

## Cihaz üzerinde kısa deneme listesi

1. `bash baslat.sh` ile başlat; ana sayfada üç örnek klasörü gör.
2. `Belgeler` içine gir; `Baslangic.txt` dosyasını aç ve indir.
3. Dosya adı filtresini, tür filtresini ve boş `Kitaplar` klasörünü dene.
4. Telefon ekranında yatay taşma olmadığını kontrol et.
5. Sisteme kurduktan sonra aynı ağa bağlı telefondan gerçek Pi IP adresiyle aç.
6. Pi'yi yeniden başlat ve hizmetin geri geldiğini dene.
7. Yalnızca gerekiyorsa ayrı Wi-Fi adımlarını uygulayıp kendi aygıtında test et.

## Klasör düzeni kontrolü

Kod ve belgeler ayrı klasörlere taşındı. Başlatma yolu, kurulum kaynak yolları ve belge bağlantıları yeni düzene göre güncellendi. Yeniden paketleme sırasında HTTP testleri ve yeni başlatma komutu tekrar denetlendi.

## Gizlilik kontrolü

Dağıtım arşivindeki metinler, dosya adları ve ZIP ek alanları incelendi. API anahtarı/token kalıpları, özel anahtar, e-posta, MAC adresi, sabit UUID ve kişisel kullanıcı dizini taramasında bulgu yoktu. Teknik adresler yalnızca yerel deneme ve varsayılan Go ağına aittir. Geliştirici adı korundu. İstek bilgilerinin normal erişim ve beklenmeyen hata günlüklerine yazılmadığını denetleyen iki HTTP testi eklendi.
