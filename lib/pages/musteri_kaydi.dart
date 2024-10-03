import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final TextEditingController _epostaController = TextEditingController();
  final TextEditingController _dogumTarihiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tcknController.text = prefs.getString('tckn') ?? '';
      _adController.text = prefs.getString('ad') ?? '';
      _soyadController.text = prefs.getString('soyad') ?? '';
      _vnController.text = prefs.getString('vn') ?? '';
      _adresController.text = prefs.getString('adres') ?? '';
      _telefonController.text = prefs.getString('telefon') ?? '';
      _sirketAdiController.text = prefs.getString('sirketAdi') ?? '';
      _epostaController.text = prefs.getString('eposta') ?? '';
      _dogumTarihiController.text = prefs.getString('dogumTarihi') ?? '';
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tckn', _tcknController.text);
    await prefs.setString('ad', _adController.text);
    await prefs.setString('soyad', _soyadController.text);
    await prefs.setString('vn', _vnController.text);
    await prefs.setString('adres', _adresController.text);
    await prefs.setString('telefon', _telefonController.text);
    await prefs.setString('sirketAdi', _sirketAdiController.text);
    await prefs.setString('eposta', _epostaController.text);
    await prefs.setString('dogumTarihi', _dogumTarihiController.text);
  }

  void _musteriKaydet() {
    String tckn = _tcknController.text;
    String ad = _adController.text;
    String soyad = _soyadController.text;
    String vn = _vnController.text;
    String adres = _adresController.text;
    String telefon = _telefonController.text;
    String sirketAdi = _sirketAdiController.text;
    String eposta = _epostaController.text;
    String dogumTarihi = _dogumTarihiController.text;

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
          sirketAdi: sirketAdi,
          eposta: eposta,
          dogumTarihi: dogumTarihi));
      _savePreferences();
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
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
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
            TextField(
              controller: _epostaController,
              decoration: const InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _dogumTarihiController,
              decoration: const InputDecoration(labelText: 'Doğum Tarihi'),
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
