#!/usr/bin/env python3
"""Optional: create, but DO NOT activate, a dedicated NetworkManager AP profile."""
import argparse
import getpass
import ipaddress
import os
from pathlib import Path
import re
import shutil
import subprocess
import uuid


def main():
    parser = argparse.ArgumentParser(description="Go Wi-Fi profili hazırlar; mevcut bağlantıyı değiştirmez.")
    parser.add_argument("interface", help="AP destekleyen ağ aygıtı, örneğin wlan1")
    args = parser.parse_args()
    if os.geteuid() != 0:
        raise SystemExit("sudo python3 scripts/prepare_wifi.py wlan1 ile çalıştırın.")
    if not re.fullmatch(r"[a-zA-Z0-9_-]{1,15}", args.interface):
        raise SystemExit("Geçersiz ağ aygıtı adı.")
    if not shutil.which("nmcli") or not shutil.which("ip"):
        raise SystemExit("NetworkManager ve iproute2 gerekli. Mevcut ağ yöneticisini değiştirmeyin.")
    def nm(*arguments):
        return subprocess.check_output(["nmcli", *arguments], text=True, env={**os.environ, "LC_ALL":"C"}).strip()
    if nm("-g", "WIFI-PROPERTIES.AP", "device", "show", args.interface) != "yes":
        raise SystemExit("Bu aygıt NetworkManager üzerinden erişim noktası modunu desteklemiyor.")
    if "BilgiKutusu-Go" in nm("-g", "NAME", "connection", "show").splitlines():
        raise SystemExit("BilgiKutusu-Go profili zaten var; üzerine yazılmadı.")
    subnet = ipaddress.ip_network("10.43.0.0/24")
    routes = subprocess.check_output(["ip", "-4", "route", "show"], text=True)
    for line in routes.splitlines():
        first = line.split()[0]
        try:
            if first != "default" and subnet.overlaps(ipaddress.ip_network(first, strict=False)):
                raise SystemExit("10.43.0.0/24 mevcut bir ağla çakışıyor; profil oluşturulmadı.")
        except ValueError:
            pass
    password = getpass.getpass("Yeni Wi-Fi şifresi (8–63 ASCII karakter): ")
    if not 8 <= len(password) <= 63 or not all(33 <= ord(c) <= 126 for c in password) or "\\" in password:
        raise SystemExit("8–63 karakter kullanın; boşluk, Türkçe harf veya ters eğik çizgi kullanmayın.")
    if password != getpass.getpass("Şifreyi tekrar yazın: "):
        raise SystemExit("Şifreler eşleşmedi.")
    profile_id = str(uuid.uuid4())
    content = f"""[connection]
id=BilgiKutusu-Go
uuid={profile_id}
type=wifi
interface-name={args.interface}
autoconnect=false

[wifi]
mode=ap
band=bg
ssid=BilgiKutusu-Go
security=802-11-wireless-security

[wifi-security]
key-mgmt=wpa-psk
proto=rsn;
psk={password}

[ipv4]
method=shared
address1=10.43.0.1/24

[ipv6]
method=disabled
"""
    target = Path("/etc/NetworkManager/system-connections/BilgiKutusu-Go.nmconnection")
    fd = os.open(target, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as handle:
            handle.write(content)
        subprocess.run(["nmcli", "connection", "load", str(target)], check=True)
    except Exception:
        target.unlink(missing_ok=True)
        raise
    print("Profil hazır; mevcut bağlantı değiştirilmedi ve otomatik başlama kapalı.")
    print("Etkinleştirme için docs/WIFI.md dosyasını okuyun.")


if __name__ == "__main__":
    main()
