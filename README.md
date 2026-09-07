
# Satış Veritabanı Analizi (SQL)

Bu projede SQLite kullanarak basit bir e-ticaret senaryosu kurdum ve SQL ile iş sorularına cevap aramaya çalıştım. Müşteriler, Ürünler ve Siparişler olmak üzere 3 tablo var; amacım en çok satan ürünleri, en değerli müşterileri, şehirlere göre performansı ve aylık ciro trendini SQL sorgularıyla bulmaktı.

> Not: Gerçek bir şirket verisi kullanmadım, veritabanını Python ile kendim (rastgele ama gerçekçi sayılarla) oluşturdum.

## Kullandığım Araçlar

- SQL (SQLite)
- Python (veri üretmek için)

## Veritabanı Yapısı

```
Musteriler (MusteriID, AdSoyad, Sehir, UyelikTarihi)
Urunler    (UrunID, UrunAdi, Kategori, BirimFiyat)
Siparisler (SiparisID, MusteriID, UrunID, Adet, SiparisTarihi)
```

50 müşteri, 10 ürün, 600 sipariş.

## Kullandığım SQL Teknikleri

- JOIN (INNER/LEFT)
- GROUP BY / HAVING
- Subquery
- strftime ile tarih bazlı analiz
- ORDER BY / LIMIT

Tüm sorgular `sorgular.sql` dosyasında, hepsi 7 tane.

## Bulduklarım

En çok ciro getiren ürün Akıllı Saat oldu — 434.000 TL, 124 satış. Elektronik kategorisi toplam cironun yaklaşık yarısını (%52) tek başına götürüyor. Şehir bazında Ankara en yüksek harcamaya sahip, Antalya ikinci sırada. En değerli müşteriler ortalamanın çok üzerinde (17-21) sipariş veren, çoğunlukla Ankara/Antalya'lı küçük bir grup — bunlara özel bir sadakat programı düşünülebilir diye yorumladım.

## Dosyalar

- `veritabani_olustur.py` — veritabanı üretim kodu
- `satis_veritabani.db` — SQLite veritabanı dosyası
- `sorgular.sql` — 7 farklı iş sorusu için SQL sorguları

## Nasıl Çalıştırılır

```
python veritabani_olustur.py
sqlite3 satis_veritabani.db < sorgular.sql
```

Ya da [DB Browser for SQLite](https://sqlitebrowser.org/) ile `satis_veritabani.db` dosyasını açıp sorguları arayüzden çalıştırabilirsiniz.

Hazırlayan: Sena Bolat*
