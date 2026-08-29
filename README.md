# Satış Veritabanı Analizi (SQL)

## Proje Hakkında
Bu projede, bir e-ticaret şirketinin satış verisi üzerinde **SQL ile iş analizi** yapılmıştır. Veritabanı 3 tablodan oluşuyor: Müşteriler, Ürünler ve Siparişler. Amaç; en çok satan ürünler, en değerli müşteriler, şehir bazlı performans ve aylık ciro trendleri gibi soruları SQL sorgularıyla yanıtlamaktır.

> Not: Veritabanı, gerçekçi dağılımlar temel alınarak Python ile **sentetik olarak** üretilmiştir (`veritabani_olustur.py`). Gerçek bir şirkete ait veri kullanılmamıştır.

## Kullanılan Araçlar
- SQL (SQLite)
- Python (veri üretimi için)

## Veritabanı Yapısı
```
Musteriler (MusteriID, AdSoyad, Sehir, UyelikTarihi)
Urunler    (UrunID, UrunAdi, Kategori, BirimFiyat)
Siparisler (SiparisID, MusteriID, UrunID, Adet, SiparisTarihi)
```
50 müşteri, 10 ürün, 600 sipariş.

## Kullanılan SQL Teknikleri
- `JOIN` (INNER JOIN, LEFT JOIN)
- `GROUP BY` / `HAVING` ile toplulaştırma
- Subquery (iç içe sorgu)
- `strftime` ile tarih bazlı analiz
- `ORDER BY` / `LIMIT` ile sıralama ve filtreleme

Tüm sorgular `sorgular.sql` dosyasında.

## Örnek Bulgular

**En çok ciro getiren ürün: Akıllı Saat** — 434.000 TL toplam ciro, 124 adet satış.

| Ürün | Kategori | Toplam Ciro |
|---|---|---|
| Akıllı Saat | Elektronik | 434.000 TL |
| Ofis Sandalyesi | Mobilya | 274.400 TL |
| Spor Ayakkabı | Giyim | 171.000 TL |

**Kategori bazında Elektronik en yüksek ciroyu üretiyor** (731.200 TL, 250 sipariş) — toplam cironun yaklaşık %52'si tek kategoriden geliyor.

**Şehir bazında Ankara en yüksek toplam harcamaya sahip** (427.450 TL, 13 müşteri), bunu Antalya takip ediyor.

**En değerli müşteri profili**, ortalama sipariş sayısının çok üzerinde (17-21 sipariş) alışveriş yapan, çoğunlukla Ankara ve Antalya'dan küçük bir müşteri grubu — bu, sadakat programı için hedef kitle olabilir.

## Dosyalar
- `veritabani_olustur.py` — sentetik veritabanı üretim kodu
- `satis_veritabani.db` — SQLite veritabanı dosyası
- `sorgular.sql` — 7 farklı iş sorusu için SQL sorguları

## Nasıl Çalıştırılır
```bash
python veritabani_olustur.py
sqlite3 satis_veritabani.db < sorgular.sql
```
Ya da [DB Browser for SQLite](https://sqlitebrowser.org/) ile `satis_veritabani.db` dosyasını açıp sorguları arayüzden çalıştırabilirsiniz.

---
*Hazırlayan: Sena Bolat*
