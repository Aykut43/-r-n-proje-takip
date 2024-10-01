import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';

class MusteriKaydiPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const MusteriKaydiPage({super.key, required this.musteriYonetimi});

  @override
  MusteriKaydiPageState createState() => MusteriKaydiPageState();
}

class MusteriKaydiPageState extends State<MusteriKaydiPage> {
  final TextEditingController _tcknController = TextEditingController();
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _soyadController = TextEditingController();
  final TextEditingController _vnController = TextEditingController();
  final TextEditingController _adresController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _sirketAdiController = TextEditingController();

  void _musteriKaydet() {
    String tckn = _tcknController.text;
    String ad = _adController.text;
    String soyad = _soyadController.text;
    String vn = _vnController.text;
    String adres = _adresController.text;
    String telefon = _telefonController.text;
    String sirketAdi = _sirketAdiController.text;

    bool isPersonalInfoValid = ad.isNotEmpty && soyad.isNotEmpty;
    bool isCompanyInfoValid = sirketAdi.isNotEmpty;

    if ((tckn.isNotEmpty || vn.isNotEmpty) &&
        (isPersonalInfoValid || isCompanyInfoValid) &&
        adres.isNotEmpty &&
        telefon.isNotEmpty) {
      widget.musteriYonetimi.musteriEkle(Musteri(
          ad: ad,
          soyad: soyad,
          tckn: tckn,
          vn: vn,
          adres: adres,
          telefon: telefon,
          sirketAdi: sirketAdi));
      Navigator.of(context).pop();
    } else {
      // Hata mesajı göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text(
                'Lütfen tüm alanları doldurun ve TCKN veya Vergi Numarası girin. Ayrıca, ad ve soyad veya şirket adı girin.'),
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
        title: const Text('Müşteri Kaydı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tcknController,
              decoration: const InputDecoration(labelText: 'TCKN'),
            ),
            TextField(
              controller: _adController,
              decoration: const InputDecoration(labelText: 'Ad'),
            ),
            TextField(
              controller: _soyadController,
              decoration: const InputDecoration(labelText: 'Soyad'),
            ),
            TextField(
              controller: _vnController,
              decoration: const InputDecoration(labelText: 'Vergi Numarası'),
            ),
            TextField(
              controller: _adresController,
              decoration: const InputDecoration(labelText: 'Adres'),
            ),
            TextField(
              controller: _telefonController,
              decoration: const InputDecoration(labelText: 'Telefon Numarası'),
            ),
            TextField(
              controller: _sirketAdiController,
              decoration: const InputDecoration(labelText: 'Şirket Adı'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _musteriKaydet,
                child: const Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
