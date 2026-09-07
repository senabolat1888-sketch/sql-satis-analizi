-- ============================================================
-- Satış Veritabanı Analizi — SQL Sorguları
-- Veritabanı: satis_veritabani.db (SQLite)
-- Tablolar: Musteriler, Urunler, Siparisler
-- ============================================================

-- 1) En çok ciro getiren 5 ürün (JOIN + GROUP BY + ORDER BY)
SELECT
    u.UrunAdi,
    u.Kategori,
    SUM(s.Adet) AS ToplamSatisAdedi,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS ToplamCiro
FROM Siparisler s
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY u.UrunID
ORDER BY ToplamCiro DESC
LIMIT 5;

-- 2) Kategoriye göre toplam ciro ve ortalama sipariş adedi
SELECT
    u.Kategori,
    COUNT(s.SiparisID) AS SiparisSayisi,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS ToplamCiro,
    ROUND(AVG(s.Adet), 2) AS OrtalamaAdet
FROM Siparisler s
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY u.Kategori
ORDER BY ToplamCiro DESC;

-- 3) Şehre göre müşteri sayısı ve toplam harcama (JOIN + GROUP BY)
SELECT
    m.Sehir,
    COUNT(DISTINCT m.MusteriID) AS MusteriSayisi,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS ToplamHarcama
FROM Musteriler m
JOIN Siparisler s ON m.MusteriID = s.MusteriID
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY m.Sehir
ORDER BY ToplamHarcama DESC;

-- 4) En değerli 5 müşteri (Customer Lifetime Value benzeri analiz)
SELECT
    m.AdSoyad,
    m.Sehir,
    COUNT(s.SiparisID) AS SiparisSayisi,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS ToplamHarcama
FROM Musteriler m
JOIN Siparisler s ON m.MusteriID = s.MusteriID
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY m.MusteriID
ORDER BY ToplamHarcama DESC
LIMIT 10;

-- 5) Ortalama sipariş tutarının üzerinde harcayan müşteriler (Subquery kullanımı)
SELECT
    m.AdSoyad,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS ToplamHarcama
FROM Musteriler m
JOIN Siparisler s ON m.MusteriID = s.MusteriID
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY m.MusteriID
HAVING ToplamHarcama > (
    SELECT AVG(MusteriToplam) FROM (
        SELECT SUM(s2.Adet * u2.BirimFiyat) AS MusteriToplam
        FROM Siparisler s2
        JOIN Urunler u2 ON s2.UrunID = u2.UrunID
        GROUP BY s2.MusteriID
    )
)
ORDER BY ToplamHarcama DESC;

-- 6) Aylık ciro trendi (Tarih fonksiyonu kullanımı)
SELECT
    strftime('%Y-%m', s.SiparisTarihi) AS Ay,
    ROUND(SUM(s.Adet * u.BirimFiyat), 2) AS AylikCiro
FROM Siparisler s
JOIN Urunler u ON s.UrunID = u.UrunID
GROUP BY Ay
ORDER BY Ay;

-- 7) Hiç sipariş vermemiş müşteriler (LEFT JOIN + IS NULL)
SELECT m.AdSoyad, m.Sehir
FROM Musteriler m
LEFT JOIN Siparisler s ON m.MusteriID = s.MusteriID
WHERE s.SiparisID IS NULL;
