#!/usr/bin/env bash
# Copyright (c) 2026 Ali Can Yılmaz. See LICENSE.
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
APP_DIR=/opt/bilgikutusu-go
CONTENT_DIR=/srv/bilgikutusu-go/icerik
CONFIG_DIR=/etc/bilgikutusu-go
UNIT=/etc/systemd/system/bilgikutusu-go.service
if [[ ${EUID} -ne 0 ]]; then echo 'sudo bash install/kur.sh ile çalıştırın.' >&2; exit 1; fi
for program in python3 systemctl runuser useradd install; do
  command -v "$program" >/dev/null || { echo "Gerekli komut yok: $program" >&2; exit 1; }
done
[[ -d /run/systemd/system ]] || { echo 'Bu kurulum systemd kullanan Linux içindir.' >&2; exit 1; }
# Never overwrite another installation or the existing BilgiKutusu contents.
for target in "$APP_DIR" "$CONFIG_DIR" "$UNIT" /srv/bilgikutusu-go; do
  if [[ -e "$target" || -L "$target" ]]; then
    echo "Kurulum durdu: $target zaten var. Önce docs/KURULUM.md dosyasını okuyun." >&2
    exit 1
  fi
done
python3 - <<'PY'
import socket, sys
if sys.version_info < (3, 9): raise SystemExit('Python 3.9 veya yenisi gerekli.')
with socket.socket() as sock:
    try: sock.bind(('0.0.0.0', 8090))
    except OSError: raise SystemExit('8090 portu kullanımda. Mevcut hizmet durdurulmadı.')
PY
if id bilgikutusu-go >/dev/null 2>&1; then
  echo 'bilgikutusu-go kullanıcısı zaten var. Elle inceleme gerekli; kurulum durdu.' >&2
  exit 1
fi
useradd --system --user-group --no-create-home --home-dir /nonexistent --shell /usr/sbin/nologin bilgikutusu-go
install -d -m 0755 "$APP_DIR/web" "$CONFIG_DIR" "$CONTENT_DIR/Belgeler" "$CONTENT_DIR/Kitaplar" "$CONTENT_DIR/Gorseller"
install -m 0644 "$SOURCE_DIR/app/app.py" "$SOURCE_DIR/LICENSE" "$APP_DIR/"
install -m 0644 "$SOURCE_DIR"/app/web/* "$APP_DIR/web/"
install -m 0644 "$SOURCE_DIR/content/Belgeler/Baslangic.txt" "$CONTENT_DIR/Belgeler/"
python3 - "$CONFIG_DIR/config.json" "$CONTENT_DIR" <<'PY'
import json, sys
from pathlib import Path
Path(sys.argv[1]).write_text(json.dumps({
    'host': '0.0.0.0', 'port': 8090, 'content_dir': sys.argv[2],
    'max_clients': 8, 'max_entries': 2000
}, ensure_ascii=False, indent=2)+'\n')
PY
chmod 0644 "$CONFIG_DIR/config.json"
install -m 0644 "$SOURCE_DIR/install/bilgikutusu-go.service" "$UNIT"
runuser -u bilgikutusu-go -- python3 "$APP_DIR/app.py" --config "$CONFIG_DIR/config.json" --check
systemctl daemon-reload
systemctl enable --now bilgikutusu-go.service
python3 - <<'PY'
import json, time, urllib.request
for attempt in range(20):
    try:
        with urllib.request.urlopen('http://127.0.0.1:8090/api/health', timeout=2) as response:
            assert json.load(response)['ok']
        print('BilgiKutusu Go çalışıyor. Port: 8090')
        break
    except Exception:
        if attempt == 19: raise SystemExit('Hizmet doğrulanamadı. sudo journalctl -u bilgikutusu-go -n 30 komutunu çalıştırın.')
        time.sleep(.25)
PY
echo "İçerik klasörü: $CONTENT_DIR"
echo 'Cihazın IP adreslerini hostname -I komutuyla görebilirsiniz.'
echo 'Mevcut Wi-Fi, nginx, Kiwix ve depolama ayarları değiştirilmedi.'
