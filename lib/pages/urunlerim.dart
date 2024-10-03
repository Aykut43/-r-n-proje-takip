import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrunlerimPage extends StatefulWidget {
  const UrunlerimPage({super.key});

  static List<Map<String, dynamic>> urunler = [
    {'isim': 'Kalem', 'fiyat': '5 TL', 'adet': 100},
    {'isim': 'Defter', 'fiyat': '10 TL', 'adet': 50},
    {'isim': 'Silgi', 'fiyat': '2 TL', 'adet': 200},
    {'isim': 'Kalemtraş', 'fiyat': '3 TL', 'adet': 75},
    {'isim': 'Cetvel', 'fiyat': '4 TL', 'adet': 60},
    {'isim': 'Makas', 'fiyat': '7 TL', 'adet': 40},
    {'isim': 'Yapıştırıcı', 'fiyat': '6 TL', 'adet': 90},
    {'isim': 'Dosya', 'fiyat': '8 TL', 'adet': 30},
    {'isim': 'Kalem Kutusu', 'fiyat': '15 TL', 'adet': 20},
    {'isim': 'Renkli Kalemler', 'fiyat': '20 TL', 'adet': 10},
  ];

  @override
  UrunlerimPageState createState() => UrunlerimPageState();
}

class UrunlerimPageState extends State<UrunlerimPage> {
  @override
  void initState() {
    super.initState();
    _loadUrunler();
  }

  void _loadUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? urunlerString = prefs.getStringList('urunler');
    if (urunlerString != null) {
      setState(() {
        UrunlerimPage.urunler = urunlerString.map((urun) {
          Map<String, dynamic> urunMap = {};
          urun.split(',').forEach((element) {
            List<String> keyValue = element.split(':');
            urunMap[keyValue[0]] = keyValue[1];
          });
          return urunMap;
        }).toList();
      });
    }
  }

  void _saveUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> urunlerString = UrunlerimPage.urunler.map((urun) {
      return urun.entries.map((e) => '${e.key}:${e.value}').join(',');
    }).toList();
    prefs.setStringList('urunler', urunlerString);
  }

  void _urunEkle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController isimController = TextEditingController();
        final TextEditingController fiyatController = TextEditingController();
        final TextEditingController adetController = TextEditingController();

        return AlertDialog(
          title: const Text('Ürün Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: isimController,
                decoration: const InputDecoration(labelText: 'Ürün İsmi'),
              ),
              TextField(
                controller: fiyatController,
                decoration: const InputDecoration(labelText: 'Fiyat'),
              ),
              TextField(
                controller: adetController,
                decoration: const InputDecoration(labelText: 'Adet'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  UrunlerimPage.urunler.add({
                    'isim': isimController.text,
                    'fiyat': fiyatController.text,
                    'adet': int.parse(adetController.text),
                  });
                  _saveUrunler();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  void _urunGuncelle(int index) {
    // Ürün güncelleme işlemleri burada yapılabilir
  }

  void _urunSil(int index) {
    setState(() {
      UrunlerimPage.urunler.removeAt(index);
      _saveUrunler();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ürün silindi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final urunler = UrunlerimPage.urunler;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünlerim'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _urunEkle,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: urunler.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            urunler[index]['isim']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            urunler[index]['fiyat']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Adet: ${urunler[index]['adet']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _urunGuncelle(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _urunSil(index),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
