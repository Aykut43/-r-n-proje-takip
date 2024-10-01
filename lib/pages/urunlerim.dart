import 'package:flutter/material.dart';

class UrunlerimPage extends StatelessWidget {
  const UrunlerimPage({super.key});

  static final List<Map<String, String>> urunler = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünlerim'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
