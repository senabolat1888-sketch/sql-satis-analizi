"""
Satış Veritabanı Analizi — Veritabanı Kurulum Scripti
Sentetik bir e-ticaret satış veri seti oluşturur (Müşteriler, Ürünler, Siparişler).
"""

import sqlite3
import random
from datetime import datetime, timedelta

random.seed(42)
conn = sqlite3.connect("satis_veritabani.db")
cur = conn.cursor()

cur.executescript("""
DROP TABLE IF EXISTS Siparisler;
DROP TABLE IF EXISTS Musteriler;
DROP TABLE IF EXISTS Urunler;

CREATE TABLE Musteriler (
    MusteriID INTEGER PRIMARY KEY,
    AdSoyad TEXT,
    Sehir TEXT,
    UyelikTarihi TEXT
);

CREATE TABLE Urunler (
    UrunID INTEGER PRIMARY KEY,
    UrunAdi TEXT,
    Kategori TEXT,
    BirimFiyat REAL
);

CREATE TABLE Siparisler (
    SiparisID INTEGER PRIMARY KEY,
    MusteriID INTEGER,
    UrunID INTEGER,
    Adet INTEGER,
    SiparisTarihi TEXT,
    FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID),
    FOREIGN KEY (UrunID) REFERENCES Urunler(UrunID)
);
""")

sehirler = ["Bursa", "İstanbul", "Ankara", "İzmir", "Antalya", "Eskişehir"]
isimler = ["Ahmet Yılmaz", "Ayşe Kaya", "Mehmet Demir", "Zeynep Şahin", "Ali Çelik",
           "Elif Yıldız", "Can Aydın", "Fatma Arslan", "Emre Koç", "Ece Doğan",
           "Burak Kurt", "Selin Aksoy", "Kerem Erdem", "Deniz Polat", "Merve Şen"]

musteriler = []
for i in range(1, 51):
    ad = random.choice(isimler) + f" {i}"
    sehir = random.choice(sehirler)
    tarih = (datetime(2023, 1, 1) + timedelta(days=random.randint(0, 800))).strftime("%Y-%m-%d")
    musteriler.append((i, ad, sehir, tarih))
cur.executemany("INSERT INTO Musteriler VALUES (?,?,?,?)", musteriler)

urunler_liste = [
    ("Kablosuz Kulaklık", "Elektronik", 1200),
    ("Akıllı Saat", "Elektronik", 3500),
    ("Laptop Çantası", "Aksesuar", 450),
    ("Ofis Sandalyesi", "Mobilya", 2800),
    ("Masa Lambası", "Mobilya", 650),
    ("Spor Ayakkabı", "Giyim", 1800),
    ("Sırt Çantası", "Aksesuar", 900),
    ("Bluetooth Hoparlör", "Elektronik", 1100),
    ("Termos", "Aksesuar", 250),
    ("Klavye", "Elektronik", 750),
]
urunler = [(i + 1, u[0], u[1], u[2]) for i, u in enumerate(urunler_liste)]
cur.executemany("INSERT INTO Urunler VALUES (?,?,?,?)", urunler)

siparisler = []
sid = 1
for _ in range(600):
    musteri_id = random.randint(1, 50)
    urun_id = random.randint(1, 10)
    adet = random.choice([1, 1, 1, 2, 2, 3])
    tarih = (datetime(2024, 1, 1) + timedelta(days=random.randint(0, 600))).strftime("%Y-%m-%d")
    siparisler.append((sid, musteri_id, urun_id, adet, tarih))
    sid += 1
cur.executemany("INSERT INTO Siparisler VALUES (?,?,?,?,?)", siparisler)

conn.commit()
conn.close()
print("satis_veritabani.db oluşturuldu: 50 müşteri, 10 ürün, 600 sipariş")
