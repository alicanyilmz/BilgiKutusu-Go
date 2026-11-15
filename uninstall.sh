#!/usr/bin/env bash
set -euo pipefail
[[ ${EUID} -eq 0 ]] || { echo 'sudo bash scripts/uninstall.sh ile çalıştırın.'; exit 1; }
systemctl disable --now bilgikutusu-go.service 2>/dev/null || true
# Keep content, config and service account so ownership and user data are preserved.
rm -f -- /etc/systemd/system/bilgikutusu-go.service
rm -rf -- /opt/bilgikutusu-go
systemctl daemon-reload
echo 'Go hizmeti kaldırıldı. İçerikler, ayarlar, hizmet kullanıcısı ve Wi-Fi profilleri korundu.'
echo 'İçerikler: /srv/bilgikutusu-go/icerik ; ayarlar: /etc/bilgikutusu-go'
