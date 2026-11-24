import os
from functools import wraps
from flask import Flask, render_template, request, redirect, url_for, session, flash, abort, make_response
import csv
import io
import secrets
from datetime import date, timedelta
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment
import pymysql
from pymysql.cursors import DictCursor
from werkzeug.security import check_password_hash

app = Flask(__name__)
app.secret_key = os.getenv("SECRET_KEY", "ganti-secret-key-ini-sebelum-deploy")
app.config.update(SESSION_COOKIE_HTTPONLY=True, SESSION_COOKIE_SAMESITE="Lax")

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "127.0.0.1"),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "kos_kosan"),
    "port": int(os.getenv("DB_PORT", "3306")),
    "cursorclass": DictCursor,
    "autocommit": True,
}

def db():
    return pymysql.connect(**DB_CONFIG)

TABLES = {
    "pemilik": {
        "title": "Pemilik", "pk": "id_pemilik",
        "fields": [
            ("nama_pemilik", "Nama pemilik", "text", True),
            ("no_telp", "Nomor telepon", "text", True),
        ],
    },
    "penghuni": {
        "title": "Penghuni", "pk": "id_penghuni",
        "fields": [
            ("nama_penghuni", "Nama penghuni", "text", True),
            ("no_telp", "Nomor telepon", "text", True),
            ("asal", "Asal", "text", True),
            ("pekerjaan", "Pekerjaan", "text", True),
        ],
    },
    "gedung_kos": {
        "title": "Gedung kos", "pk": "id_gedung",
        "fields": [
            ("id_pemilik", "Pemilik", "fk:pemilik:id_pemilik:nama_pemilik", True),
            ("nama_gedung", "Nama gedung", "text", True),
            ("total_kamar", "Total kamar", "number", True),
            ("jumlah_lantai", "Jumlah lantai", "number", True),
            ("alamat", "Alamat", "textarea", True),
        ],
    },
    "kamar": {
        "title": "Kamar", "pk": "id_kamar",
        "fields": [
            ("id_gedung", "Gedung", "fk:gedung_kos:id_gedung:nama_gedung", True),
            ("no_kamar", "Nomor kamar", "text", True),
            ("lantai", "Lantai", "number", True),
            ("harga_sewa", "Harga sewa", "number", True),
            ("status_kamar", "Status kamar", "select:tersedia|terisi|perbaikan", True),
        ],
    },
    "akun_pengguna": {
        "title": "Akun pengguna", "pk": "id_user",
        "fields": [
            ("id_penghuni", "Penghuni (opsional)", "fk_optional:penghuni:id_penghuni:nama_penghuni", False),
            ("id_pemilik", "Pemilik (opsional)", "fk_optional:pemilik:id_pemilik:nama_pemilik", False),
            ("username", "Username", "text", True),
            ("password", "Password baru (kosongkan saat edit)", "password", False),
            ("role", "Role", "select:admin|pemilik|penghuni", True),
        ],
    },
    "fasilitas_kamar": {
        "title": "Fasilitas kamar", "pk": "id_fasilitas",
        "fields": [
            ("id_kamar", "Kamar", "fk:kamar:id_kamar:no_kamar", True),
            ("nama_fasilitas", "Nama fasilitas", "text", True),
            ("kondisi", "Kondisi", "text", True),
        ],
    },
    "kontrak_sewa": {
        "title": "Kontrak sewa", "pk": "id_kontrak",
        "fields": [
            ("id_penghuni", "Penghuni", "fk:penghuni:id_penghuni:nama_penghuni", True),
            ("id_kamar", "Kamar", "fk:kamar:id_kamar:no_kamar", True),
            ("tanggal_mulai", "Tanggal mulai", "date", True),
            ("tanggal_selesai", "Tanggal selesai", "date", True),
            ("status_kontrak", "Status kontrak", "select:aktif|selesai|dibatalkan", True),
        ],
    },
    "tagihan_bulanan": {
        "title": "Tagihan bulanan", "pk": "id_tagihan",
        "fields": [
            ("id_kontrak", "Kontrak", "fk:kontrak_sewa:id_kontrak:id_kontrak", True),
            ("bulan_tagihan", "Bulan tagihan", "date", True),
            ("jumlah_tagihan", "Jumlah tagihan", "number", True),
            ("tanggal_jatuh_tempo", "Jatuh tempo", "date", True),
            ("status_tagihan", "Status tagihan", "select:belum_bayar|sebagian|lunas", True),
        ],
    },
    "pembayaran": {
        "title": "Pembayaran", "pk": "id_pembayaran",
        "fields": [
            ("id_tagihan", "Tagihan", "fk:tagihan_bulanan:id_tagihan:id_tagihan", True),
            ("tanggal_pembayaran", "Tanggal pembayaran", "date", True),
            ("jumlah_pembayaran", "Jumlah pembayaran", "number", True),
            ("metode_pembayaran", "Metode pembayaran", "text", True),
        ],
    },
    "keluhan": {
        "title": "Keluhan", "pk": "id_keluhan",
        "fields": [
            ("id_penghuni", "Penghuni", "fk:penghuni:id_penghuni:nama_penghuni", True),
            ("id_kamar", "Kamar", "fk:kamar:id_kamar:no_kamar", True),
            ("tanggal_keluhan", "Tanggal keluhan", "date", True),
            ("deskripsi_keluhan", "Deskripsi keluhan", "textarea", True),
            ("status_keluhan", "Status keluhan", "select:menunggu|diproses|selesai", True),
        ],
    },
}

def csrf_token():
    if "csrf_token" not in session:
        session["csrf_token"] = secrets.token_urlsafe(32)
    return session["csrf_token"]

app.jinja_env.globals["csrf_token"] = csrf_token

@app.before_request
def protect_post_requests():
    if request.method == "POST":
        sent = request.form.get("csrf_token", "")
        expected = session.get("csrf_token", "")
        if not sent or not expected or not secrets.compare_digest(sent, expected):
            abort(400, description="Sesi formulir tidak valid. Muat ulang halaman lalu coba lagi.")

def ensure_activity_table(cur):
    # Perubahan skema bersifat aditif: hanya membuat tabel baru jika belum ada.
    cur.execute("""CREATE TABLE IF NOT EXISTS aktivitas_kos (
        id_aktivitas BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        id_user INT NULL,
        username VARCHAR(50) NOT NULL,
        aktivitas VARCHAR(30) NOT NULL,
        tabel_data VARCHAR(64) NOT NULL,
        detail TEXT NULL,
        waktu TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_aktivitas_waktu (waktu),
        INDEX idx_aktivitas_user (id_user)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4""")

def log_activity(cur, action, table_name, detail=""):
    ensure_activity_table(cur)
    cur.execute("INSERT INTO aktivitas_kos (id_user, username, aktivitas, tabel_data, detail) VALUES (%s,%s,%s,%s,%s)",
                (session.get("user_id"), session.get("username", "sistem"), action, table_name, str(detail)[:1000]))

def login_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if "user_id" not in session:
            return redirect(url_for("login"))
        return fn(*args, **kwargs)
    return wrapper

def admin_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if session.get("role") != "admin":
            abort(403)
        return fn(*args, **kwargs)
    return wrapper

@app.route("/")
def index():
    if "user_id" not in session:
        return redirect(url_for("login"))
    return redirect(url_for("dashboard"))

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "").strip()
        password = request.form.get("password", "")
        conn = db()
        try:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM akun_pengguna WHERE username=%s", (username,))
                user = cur.fetchone()
        finally:
            conn.close()
        if user and check_password_hash(user["password"], password):
            session.clear()
            session["user_id"] = user["id_user"]
            session["username"] = user["username"]
            session["role"] = user["role"]
            session["csrf_token"] = secrets.token_urlsafe(32)
            try:
                conn = db()
                with conn.cursor() as cur:
                    log_activity(cur, "login", "akun_pengguna", f"Login {username}")
                conn.close()
            except Exception:
                pass
            return redirect(url_for("dashboard"))
        flash("Username atau password salah.", "error")
    return render_template("login.html")

@app.route("/logout", methods=["POST"])
@login_required
def logout():
    try:
        conn = db()
        with conn.cursor() as cur:
            log_activity(cur, "logout", "akun_pengguna", "Logout")
        conn.close()
    except Exception:
        pass
    session.clear()
    return redirect(url_for("login"))

@app.route("/dashboard")
@login_required
def dashboard():
    counts, alerts, activities = {}, {}, []
    conn = db()
    try:
        with conn.cursor() as cur:
            for table, config in TABLES.items():
                cur.execute(f"SELECT COUNT(*) AS total FROM `{table}`")
                counts[config["title"]] = cur.fetchone()["total"]
            cur.execute("SELECT COUNT(*) AS total FROM tagihan_bulanan WHERE status_tagihan <> 'lunas' AND tanggal_jatuh_tempo < CURDATE()")
            alerts["Tagihan terlambat"] = cur.fetchone()["total"]
            cur.execute("SELECT COUNT(*) AS total FROM kontrak_sewa WHERE status_kontrak = 'aktif' AND tanggal_selesai BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)")
            alerts["Kontrak berakhir ≤ 30 hari"] = cur.fetchone()["total"]
            cur.execute("SELECT COUNT(*) AS total FROM fasilitas_kamar WHERE LOWER(kondisi) NOT IN ('baik','bagus','normal')")
            alerts["Fasilitas perlu diperiksa"] = cur.fetchone()["total"]
            cur.execute("SELECT COUNT(*) AS total FROM keluhan WHERE LOWER(status_keluhan) <> 'selesai'")
            alerts["Keluhan belum selesai"] = cur.fetchone()["total"]
            ensure_activity_table(cur)
            cur.execute("SELECT username, aktivitas, tabel_data, detail, waktu FROM aktivitas_kos ORDER BY waktu DESC, id_aktivitas DESC LIMIT 8")
            activities = cur.fetchall()
    finally:
        conn.close()
    return render_template("dashboard.html", counts=counts, alerts=alerts, activities=activities)

def get_options(kind):
    parts = kind.split(":")
    table, pk, label = parts[1], parts[2], parts[3]
    conn = db()
    try:
        with conn.cursor() as cur:
            cur.execute(f"SELECT `{pk}` AS id, `{label}` AS label FROM `{table}` ORDER BY `{pk}` DESC")
            return cur.fetchall()
    finally:
        conn.close()

def get_record(table, record_id):
    config = TABLES[table]
    conn = db()
    try:
        with conn.cursor() as cur:
            cur.execute(f"SELECT * FROM `{table}` WHERE `{config['pk']}`=%s", (record_id,))
            return cur.fetchone()
    finally:
        conn.close()

def list_query_parts(table, q, filter_col, filter_value):
    config = TABLES[table]
    allowed = {f[0] for f in config["fields"]} | {config["pk"]}
    clauses, params = [], []
    if q:
        searchable = [name for name, *_ in config["fields"] if name != "password"]
        searchable.append(config["pk"])
        clauses.append("(" + " OR ".join(f"CAST(`{name}` AS CHAR) LIKE %s" for name in searchable) + ")")
        params.extend([f"%{q}%"] * len(searchable))
    if filter_col in allowed and filter_value:
        clauses.append(f"`{filter_col}`=%s")
        params.append(filter_value)
    where = (" WHERE " + " AND ".join(clauses)) if clauses else ""
    return where, params

def get_filter_choices(table, filter_col):
    allowed = {f[0] for f in TABLES[table]["fields"]}
    if filter_col not in allowed or not (filter_col.startswith("status_") or filter_col == "kondisi"):
        return []
    conn = db()
    try:
        with conn.cursor() as cur:
            cur.execute(f"SELECT DISTINCT `{filter_col}` AS value FROM `{table}` WHERE `{filter_col}` IS NOT NULL AND `{filter_col}` <> '' ORDER BY `{filter_col}`")
            return [r["value"] for r in cur.fetchall()]
    finally:
        conn.close()

def fetch_filtered_rows(table, q="", filter_col="", filter_value="", limit=None, offset=0):
    config = TABLES[table]
    where, params = list_query_parts(table, q, filter_col, filter_value)
    conn = db()
    try:
        with conn.cursor() as cur:
            cur.execute(f"SELECT COUNT(*) AS total FROM `{table}`{where}", params)
            total = cur.fetchone()["total"]
            sql = f"SELECT * FROM `{table}`{where} ORDER BY `{config['pk']}` DESC"
            if limit is not None:
                sql += " LIMIT %s OFFSET %s"
                cur.execute(sql, params + [limit, offset])
            else:
                cur.execute(sql, params)
            return cur.fetchall(), total
    finally:
        conn.close()

@app.route("/data/<table>")
@login_required
def list_data(table):
    if table not in TABLES: abort(404)
    config = TABLES[table]
    q = request.args.get("q", "").strip()[:100]
    filter_col = request.args.get("filter_col", "")
    filter_value = request.args.get("filter_value", "")[:100]
    try:
        per_page = int(request.args.get("per_page", 9))
        page = int(request.args.get("page", 1))
    except ValueError:
        per_page, page = 9, 1
    if per_page not in (9, 18, 27): per_page = 9
    page = max(page, 1)
    _, total = fetch_filtered_rows(table, q, filter_col, filter_value, limit=1, offset=0)
    pages = max(1, (total + per_page - 1) // per_page)
    page = min(page, pages)
    rows, _ = fetch_filtered_rows(table, q, filter_col, filter_value, limit=per_page, offset=(page-1)*per_page)
    filter_choices = get_filter_choices(table, filter_col)
    return render_template("list.html", table=table, config=config, rows=rows, q=q,
        filter_col=filter_col, filter_value=filter_value, filter_choices=filter_choices,
        page=page, pages=pages, per_page=per_page, total=total)

@app.route("/data/<table>/export.csv")
@login_required
def export_csv(table):
    if table not in TABLES: abort(404)
    q = request.args.get("q", "").strip()[:100]
    filter_col = request.args.get("filter_col", "")
    filter_value = request.args.get("filter_value", "")[:100]
    rows, _ = fetch_filtered_rows(table, q, filter_col, filter_value)
    output = io.StringIO()
    writer = csv.writer(output)
    headers = [TABLES[table]["pk"]] + [f[0] for f in TABLES[table]["fields"]]
    writer.writerow(headers)
    for row in rows:
        writer.writerow(["••••••••" if h == "password" else row.get(h) for h in headers])
    response = make_response("\ufeff" + output.getvalue())
    response.headers["Content-Type"] = "text/csv; charset=utf-8"
    response.headers["Content-Disposition"] = f"attachment; filename={table}.csv"
    return response

@app.route("/data/<table>/export.xlsx")
@login_required
def export_xlsx(table):
    if table not in TABLES: abort(404)
    q = request.args.get("q", "").strip()[:100]
    filter_col = request.args.get("filter_col", "")
    filter_value = request.args.get("filter_value", "")[:100]
    rows, _ = fetch_filtered_rows(table, q, filter_col, filter_value)
    headers = [TABLES[table]["pk"]] + [f[0] for f in TABLES[table]["fields"]]
    workbook = Workbook()
    sheet = workbook.active
    sheet.title = TABLES[table]["title"][:31]
    sheet.append(headers)
    for cell in sheet[1]:
        cell.font = Font(bold=True, color="FFFFFF")
        cell.fill = PatternFill("solid", fgColor="263D66")
        cell.alignment = Alignment(horizontal="center")
    for row in rows:
        sheet.append(["••••••••" if key == "password" else row.get(key) for key in headers])
    sheet.freeze_panes = "A2"
    sheet.auto_filter.ref = sheet.dimensions
    for column in sheet.columns:
        letter = column[0].column_letter
        width = min(max(max(len(str(cell.value or "")) for cell in column) + 2, 12), 32)
        sheet.column_dimensions[letter].width = width
    stream = io.BytesIO()
    workbook.save(stream)
    response = make_response(stream.getvalue())
    response.headers["Content-Type"] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    response.headers["Content-Disposition"] = f"attachment; filename={table}.xlsx"
    return response

@app.route("/aktivitas")
@login_required
@admin_required
def activity_log():
    conn = db()
    try:
        with conn.cursor() as cur:
            ensure_activity_table(cur)
            cur.execute("SELECT * FROM aktivitas_kos ORDER BY waktu DESC, id_aktivitas DESC LIMIT 200")
            rows = cur.fetchall()
    finally:
        conn.close()
    return render_template("activity.html", rows=rows)

@app.route("/data/<table>/tambah", methods=["GET", "POST"])
@login_required
@admin_required
def add_data(table):
    if table not in TABLES: abort(404)
    config = TABLES[table]
    if request.method == "POST":
        values, columns = [], []
        for name, label, kind, required in config["fields"]:
            value = request.form.get(name, "").strip()
            if name == "password":
                if not value:
                    flash("Password wajib diisi untuk akun baru.", "error")
                    return redirect(url_for("add_data", table=table))
                from werkzeug.security import generate_password_hash
                value = generate_password_hash(value)
            if value == "" and (kind.startswith("fk_optional:") or not required): value = None
            if value == "" and required:
                flash(f"{label} wajib diisi.", "error")
                return redirect(url_for("add_data", table=table))
            columns.append(name); values.append(value if value != "" else None)
        placeholders = ", ".join(["%s"] * len(columns))
        col_sql = ", ".join([f"`{c}`" for c in columns])
        conn = db()
        try:
            with conn.cursor() as cur:
                cur.execute(f"INSERT INTO `{table}` ({col_sql}) VALUES ({placeholders})", values)
                log_activity(cur, "tambah", table, f"Tambah data ID {cur.lastrowid}")
            flash("Data berhasil ditambahkan.", "success")
        except Exception:
            app.logger.exception("Gagal menambah data pada %s", table)
            flash("Gagal menyimpan data. Periksa isian dan hubungan data yang dipilih.", "error")
        finally: conn.close()
        return redirect(url_for("list_data", table=table))
    options = {f[0]: get_options(f[2]) for f in config["fields"] if f[2].startswith("fk")}
    return render_template("form.html", table=table, config=config, record=None, options=options, mode="Tambah")

@app.route("/data/<table>/edit/<int:record_id>", methods=["GET", "POST"])
@login_required
@admin_required
def edit_data(table, record_id):
    if table not in TABLES: abort(404)
    config = TABLES[table]
    record = get_record(table, record_id)
    if not record: abort(404)
    if request.method == "POST":
        sets, values = [], []
        for name, label, kind, required in config["fields"]:
            value = request.form.get(name, "").strip()
            if name == "password":
                if value:
                    from werkzeug.security import generate_password_hash
                    value = generate_password_hash(value)
                else: continue
            if value == "" and (kind.startswith("fk_optional:") or not required): value = None
            if value == "" and required:
                flash(f"{label} wajib diisi.", "error")
                return redirect(url_for("edit_data", table=table, record_id=record_id))
            sets.append(f"`{name}`=%s"); values.append(value if value != "" else None)
        values.append(record_id)
        conn = db()
        try:
            with conn.cursor() as cur:
                cur.execute(f"UPDATE `{table}` SET {', '.join(sets)} WHERE `{config['pk']}`=%s", values)
                log_activity(cur, "edit", table, f"Edit data ID {record_id}")
            flash("Data berhasil diperbarui.", "success")
        except Exception:
            app.logger.exception("Gagal mengedit data pada %s", table)
            flash("Gagal memperbarui data. Periksa isian dan hubungan data yang dipilih.", "error")
        finally: conn.close()
        return redirect(url_for("list_data", table=table))
    options = {f[0]: get_options(f[2]) for f in config["fields"] if f[2].startswith("fk")}
    return render_template("form.html", table=table, config=config, record=record, options=options, mode="Edit")

@app.route("/data/<table>/hapus/<int:record_id>", methods=["POST"])
@login_required
@admin_required
def delete_data(table, record_id):
    if table not in TABLES: abort(404)
    config = TABLES[table]
    conn = db()
    try:
        with conn.cursor() as cur:
            cur.execute(f"DELETE FROM `{table}` WHERE `{config['pk']}`=%s", (record_id,))
            if cur.rowcount:
                log_activity(cur, "hapus", table, f"Hapus data ID {record_id}")
                flash("Data berhasil dihapus.", "success")
            else: flash("Data tidak ditemukan.", "error")
    except Exception:
        app.logger.exception("Gagal menghapus data pada %s", table)
        flash("Data tidak bisa dihapus karena mungkin masih digunakan oleh data lain.", "error")
    finally: conn.close()
    return redirect(url_for("list_data", table=table))

@app.errorhandler(400)
def bad_request(error):
    return render_template("error.html", code=400, message=getattr(error, "description", "Permintaan tidak valid.")), 400

@app.errorhandler(403)
def forbidden(_):
    return render_template("error.html", code=403, message="Akses ditolak. Halaman ini hanya untuk admin."), 403

@app.errorhandler(404)
def not_found(_):
    return render_template("error.html", code=404, message="Halaman atau data yang kamu cari tidak ditemukan."), 404

if __name__ == "__main__":
    app.run(debug=os.getenv("FLASK_DEBUG", "0") == "1")
