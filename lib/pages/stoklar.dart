import 'package:flutter/material.dart';
import 'package:yeni_projem/pages/urunlerim.dart'; // Urunlerim dosyasını içe aktardık

class StoklarPage extends StatelessWidget {
  const StoklarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final urunler = UrunlerimPage.urunler;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stoklar'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: urunler.length,
          itemBuilder: (context, index) {
            final urun = urunler[index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(urun['isim']!),
                subtitle:
                    Text('Fiyat: ${urun['fiyat']}\nAdet: ${urun['adet']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
