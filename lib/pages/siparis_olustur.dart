import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart'; // Musteriler dosyasını içe aktardık

class SiparisOlusturPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const SiparisOlusturPage({super.key, required this.musteriYonetimi});

  @override
  SiparisOlusturPageState createState() => SiparisOlusturPageState();
}

class SiparisOlusturPageState extends State<SiparisOlusturPage> {
  final TextEditingController _miktarController = TextEditingController();
  final TextEditingController _adresController = TextEditingController();
  String? _selectedUrun = 'Kalem';
  String? _selectedOdemeYontemi = 'Kredi Kartı';
  Musteri? _selectedMusteri;

  final List<Map<String, String>> urunler = [
    {'isim': 'Kalem', 'fiyat': '5 TL'},
    {'isim': 'Defter', 'fiyat': '10 TL'},
    {'isim': 'Silgi', 'fiyat': '2 TL'},
    {'isim': 'Kalemtraş', 'fiyat': '3 TL'},
    {'isim': 'Cetvel', 'fiyat': '4 TL'},
    {'isim': 'Makas', 'fiyat': '7 TL'},
    {'isim': 'Yapıştırıcı', 'fiyat': '6 TL'},
    {'isim': 'Dosya', 'fiyat': '8 TL'},
    {'isim': 'Kalem Kutusu', 'fiyat': '15 TL'},
    {'isim': 'Renkli Kalemler', 'fiyat': '20 TL'},
  ];

  void _siparisOlustur() {
    String urunAdi = _selectedUrun!;
    String miktar = _miktarController.text;
    String adres = _adresController.text;

    if (_selectedMusteri != null && miktar.isNotEmpty && adres.isNotEmpty) {
      // Sipariş oluşturma işlemi
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Oluştur'),
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
                  .map<DropdownMenuItem<String>>((Map<String, String> urun) {
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
