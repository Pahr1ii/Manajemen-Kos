KOSKITA - WEB MANAJEMEN KOS (FLASK + MYSQL)

Persyaratan:
- Python 3.10+
- Laragon dengan MySQL/MariaDB aktif
- Database kos_kosan dengan 10 tabel sesuai file kos_kosan.sql

CARA MENJALANKAN DI WINDOWS / LARAGON

1. Ekstrak folder kos_kosan_web.
2. Buka Terminal Laragon, masuk ke folder project:
   cd path\ke\kos_kosan_web
3. Buat virtual environment:
   py -m venv venv
   venv\Scripts\activate
4. Install library:
   pip install -r requirements.txt
5. Pastikan database kos_kosan sudah ada dan MySQL Laragon aktif.
   Default koneksi:
   host 127.0.0.1
   user root
   password kosong
   database kos_kosan
   port 3306

   Jika konfigurasi MySQL berbeda, atur environment variable:
   set DB_HOST=127.0.0.1
   set DB_USER=root
   set DB_PASSWORD=password_mysql_kamu
   set DB_NAME=kos_kosan
   set DB_PORT=3306
   set SECRET_KEY=ganti_dengan_string_acak_yang_panjang

6. Buat akun admin jika belum ada:
   py buat_admin.py
   Masukkan username dan password saat diminta.

7. Jalankan web:
   py app.py
8. Buka browser:
   http://127.0.0.1:5000

FITUR
- Login dan logout dengan perlindungan CSRF pada formulir POST.
- Dashboard ringkasan 10 tabel.
- Pusat perhatian: tagihan terlambat, kontrak berakhir dalam 30 hari,
  fasilitas dengan kondisi selain Baik/Bagus/Normal, dan keluhan belum selesai.
- CRUD untuk 10 tabel yang sudah ada.
- Dropdown untuk memilih relasi foreign key.
- Password akun di-hash saat dibuat/diubah dan tidak diekspor dalam bentuk asli.
- Pencarian lintas kolom, filter status/kondisi, pagination 9/18/27.
- Export Excel (.xlsx), CSV, dan Print mengikuti pencarian/filter aktif.
- Activity Log untuk login, logout, tambah, edit, dan hapus.
- Light/Dark Mode dengan preferensi tema tersimpan di browser.
- Sidebar drawer pada layar kecil dan tata letak responsif.

CATATAN DATABASE DAN DATA
- Aplikasi tetap menggunakan database kos_kosan dan 10 tabel yang sudah ada.
- Tidak ada perintah DROP, TRUNCATE, atau reset data.
- Tabel tambahan `aktivitas_kos` dibuat otomatis menggunakan CREATE TABLE IF NOT EXISTS
  saat dashboard/fitur aktivitas dipakai. Tabel ini hanya menyimpan catatan aktivitas,
  tidak mengubah atau menghapus tabel lama.
- Akun MySQL yang dipakai aplikasi perlu memiliki izin CREATE TABLE untuk membuat
  tabel aktivitas tersebut. Jika tidak, berikan izin atau buat tabel itu secara manual.
- Backup database sebelum menguji aplikasi atau melakukan perubahan skema apa pun.
- MySQL akan menolak penghapusan data yang masih dipakai tabel lain oleh foreign key.

CATATAN KEAMANAN
- Jangan gunakan SECRET_KEY default untuk penggunaan di luar komputer lokal.
- Untuk produksi, gunakan HTTPS, secret key acak, debug nonaktif, dan konfigurasi
  akses/otorisasi yang ditinjau kembali.
- Aplikasi ini merupakan proyek pengembangan lokal/praktikum, belum diaudit untuk produksi.
