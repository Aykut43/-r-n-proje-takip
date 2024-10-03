import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/pages/urunlerim.dart'; // Urunlerim dosyasını içe aktardık
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiparisOlusturPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;
  final SiparisYonetimi siparisYonetimi;

  const SiparisOlusturPage(
      {super.key,
      required this.musteriYonetimi,
      required this.siparisYonetimi});

  @override
  SiparisOlusturPageState createState() => SiparisOlusturPageState();
}

class SiparisOlusturPageState extends State<SiparisOlusturPage> {
  final TextEditingController _miktarController = TextEditingController();
  final TextEditingController _adresController = TextEditingController();
  String? _selectedUrun = 'Kalem';
  String? _selectedOdemeYontemi = 'Kredi Kartı';
  Musteri? _selectedMusteri;

  final List<Map<String, dynamic>> urunler = UrunlerimPage.urunler;

  void _siparisOlustur() {
    String urunAdi = _selectedUrun!;
    String miktar = _miktarController.text;
    String adres = _adresController.text;

    if (_selectedMusteri != null && miktar.isNotEmpty && adres.isNotEmpty) {
      // Sipariş oluşturma işlemi
      widget.siparisYonetimi.siparisEkle(Siparis(
        urun: urunAdi,
        miktar: miktar,
        adres: adres,
        odeme: _selectedOdemeYontemi!,
      ));

      // Stok adedini düşürme işlemi
      setState(() {
        for (var urun in urunler) {
          if (urun['isim'] == urunAdi) {
            urun['adet'] =
                (int.parse(urun['adet']) - int.parse(miktar)).toString();
          }
        }
        _saveUrunler();
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sipariş Başarılı'),
            content: Text(
                'Siparişiniz başarıyla oluşturuldu.\n\nMüşteri: ${_selectedMusteri!.ad} ${_selectedMusteri!.soyad}\nÜrün: $urunAdi\nMiktar: $miktar\nAdres: $adres\nÖdeme Yöntemi: $_selectedOdemeYontemi'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      // Hata mesajı göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content:
                const Text('Lütfen tüm alanları doldurun ve müşteri seçin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  void _saveUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> urunlerString = urunler.map((urun) {
      return urun.entries.map((e) => '${e.key}:${e.value}').join(',');
    }).toList();
    prefs.setStringList('urunler', urunlerString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Oluştur'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Müşteri Seçin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Musteri>(
              value: _selectedMusteri,
              hint: const Text('Müşteri Seçin'),
              onChanged: (Musteri? newValue) {
                setState(() {
                  _selectedMusteri = newValue;
                });
              },
              items: widget.musteriYonetimi
                  .getMusteriler()
                  .map<DropdownMenuItem<Musteri>>((Musteri musteri) {
                return DropdownMenuItem<Musteri>(
                  value: musteri,
                  child: Text('${musteri.ad} ${musteri.soyad}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ürün Seçin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedUrun,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUrun = newValue;
                });
              },
              items: urunler
                  .map<DropdownMenuItem<String>>((Map<String, dynamic> urun) {
                return DropdownMenuItem<String>(
                  value: urun['isim'],
                  child: Text('${urun['isim']} - ${urun['fiyat']}'),
                );
              }).toList(),
            ),
            TextField(
              controller: _miktarController,
              decoration: const InputDecoration(labelText: 'Miktar'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _adresController,
              decoration: const InputDecoration(labelText: 'Teslimat Adresi'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ödeme Yöntemi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedOdemeYontemi,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOdemeYontemi = newValue;
                });
              },
              items: <String>['Kredi Kartı', 'Banka Havalesi', 'Kapıda Ödeme']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _siparisOlustur,
                child: const Text('Sipariş Oluştur'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
