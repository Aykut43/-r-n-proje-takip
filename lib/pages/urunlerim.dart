import 'package:flutter/material.dart';

class UrunlerimPage extends StatelessWidget {
  const UrunlerimPage({super.key});

  static final List<Map<String, dynamic>> urunler = [
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
                    const SizedBox(height: 8.0),
                    Text(
                      'Adet: ${urunler[index]['adet']}',
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
