#!/data/data/com.termux/files/usr/bin/bash

set -e

# Pastikan dijalankan dari direktori repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Direktori ini bukan repository Git."
    exit 1
fi

# Tambahkan perubahan file ke staging
git add -A

# Periksa apakah ada perubahan
if git diff --cached --quiet; then
    echo "Tidak ada perubahan file untuk di-commit."
    exit 0
fi

# Ambil nama seluruh file yang masuk ke commit
FILES=$(git diff --cached --name-only | while IFS= read -r file; do
    basename "$file"
done | paste -sd ', ' -)

# Buat pesan commit
MESSAGE="upload file ${FILES}"

echo "================================"
echo "File   : ${FILES}"
echo "Pesan  : ${MESSAGE}"
echo "================================"

# Commit dan push
git commit -m "$MESSAGE"
git push origin main

echo "================================"
echo "Upload berhasil!"
echo "================================"
