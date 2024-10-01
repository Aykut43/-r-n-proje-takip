import 'package:flutter/material.dart';

class SiparislerPage extends StatelessWidget {
  const SiparislerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek sipariş verileri
    final List<Map<String, String>> siparisler = [
      {
        'urun': 'Kalem',
        'miktar': '10',
        'adres': 'İstanbul',
        'odeme': 'Kredi Kartı'
      },
      {
        'urun': 'Defter',
        'miktar': '5',
        'adres': 'Ankara',
        'odeme': 'Banka Havalesi'
      },
      {
        'urun': 'Silgi',
        'miktar': '20',
        'adres': 'İzmir',
        'odeme': 'Kapıda Ödeme'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: siparisler.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(siparisler[index]['urun']!),
                subtitle: Text(
                    'Miktar: ${siparisler[index]['miktar']}\nAdres: ${siparisler[index]['adres']}\nÖdeme Yöntemi: ${siparisler[index]['odeme']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
