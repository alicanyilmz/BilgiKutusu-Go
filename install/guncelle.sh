#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
[[ ${EUID} -eq 0 ]] || { echo 'sudo bash install/guncelle.sh ile çalıştırın.'; exit 1; }
[[ -f /etc/bilgikutusu-go/config.json ]] || { echo 'Korunmuş Go ayarı yok. Önce kur.sh kullanın.'; exit 1; }
id bilgikutusu-go >/dev/null || { echo 'Go hizmet kullanıcısı yok.'; exit 1; }
python3 "$SOURCE_DIR/app/app.py" --config /etc/bilgikutusu-go/config.json --check
if [[ -d /opt/bilgikutusu-go ]]; then
  install -d -m 0700 /var/backups
  BACKUP_DIR="$(mktemp -d /var/backups/bilgikutusu-go.XXXXXX)"
  cp -a /opt/bilgikutusu-go "$BACKUP_DIR/"
  if [[ -f /etc/systemd/system/bilgikutusu-go.service ]]; then cp -a /etc/systemd/system/bilgikutusu-go.service "$BACKUP_DIR/"; fi
  echo "Eski kod yedeği: $BACKUP_DIR"
fi
install -d -m 0755 /opt/bilgikutusu-go/web
install -m 0644 "$SOURCE_DIR/app/app.py" "$SOURCE_DIR/LICENSE" /opt/bilgikutusu-go/
install -m 0644 "$SOURCE_DIR"/app/web/* /opt/bilgikutusu-go/web/
install -m 0644 "$SOURCE_DIR/install/bilgikutusu-go.service" /etc/systemd/system/bilgikutusu-go.service
runuser -u bilgikutusu-go -- python3 /opt/bilgikutusu-go/app.py --config /etc/bilgikutusu-go/config.json --check
systemctl daemon-reload
systemctl enable bilgikutusu-go.service
systemctl restart bilgikutusu-go.service
systemctl --no-pager status bilgikutusu-go.service
echo 'Kod güncellendi. İçerikler ve ayarlar korundu.'
