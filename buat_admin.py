"""Jalankan sekali untuk membuat hash password akun admin."""
import getpass
import pymysql
from werkzeug.security import generate_password_hash

conn = pymysql.connect(
    host="127.0.0.1", user="root", password="",
    database="kos_kosan", charset="utf8mb4"
)
username = input("Username admin: ").strip()
password = getpass.getpass("Password admin: ")
conn.autocommit(True)
try:
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO akun_pengguna (id_penghuni, id_pemilik, username, password, role) "
            "VALUES (NULL, NULL, %s, %s, 'admin')",
            (username, generate_password_hash(password))
        )
    print("Akun admin berhasil dibuat.")
except Exception as e:
    print("Gagal membuat akun:", e)
finally:
    conn.close()
