# Teknik başvuru kaynakları

Uygulama kodu bu paket için hazırlanmıştır. Harici JavaScript/CSS kütüphanesi, font, fotoğraf veya medya arşivi paketlenmemiştir.

- Python HTTP işleyicileri ve yerel kullanım sınırlamaları: https://docs.python.org/3/library/http.server.html
- NetworkManager nmcli: https://networkmanager.dev/docs/api/latest/nmcli.html
- NetworkManager keyfile biçimi: https://networkmanager.dev/docs/api/latest/nm-settings-keyfile.html
- systemd hizmet çalıştırma seçenekleri: https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html

Python belgeleri `http.server` altyapısını genel üretim hizmetleri için önermez. Bu paket küçük ve güvenilir yerel ağlarda dosya paylaşımı için sınırlandırılmıştır; internete açık barındırma çözümü değildir.
