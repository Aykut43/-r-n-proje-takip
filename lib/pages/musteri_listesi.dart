import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';

class MusteriListesiPage extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;

  const MusteriListesiPage({super.key, required this.musteriYonetimi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Listesi'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: musteriYonetimi.getMusteriler().length,
        itemBuilder: (context, index) {
          final musteri = musteriYonetimi.getMusteriler()[index];
          return ListTile(
            title: Text('${musteri.ad} ${musteri.soyad}'),
            subtitle: Text(musteri.sirketAdi),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusteriDetayPage(musteri: musteri),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MusteriDetayPage extends StatelessWidget {
  final Musteri musteri;

  const MusteriDetayPage({super.key, required this.musteri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Detayları'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ad: ${musteri.ad}', style: const TextStyle(fontSize: 18)),
            Text('Soyad: ${musteri.soyad}',
                style: const TextStyle(fontSize: 18)),
            Text('Şirket Adı: ${musteri.sirketAdi}',
                style: const TextStyle(fontSize: 18)),
            Text('TCKN: ${musteri.tckn}', style: const TextStyle(fontSize: 18)),
            Text('Vergi Numarası: ${musteri.vn}',
                style: const TextStyle(fontSize: 18)),
            Text('Adres: ${musteri.adres}',
                style: const TextStyle(fontSize: 18)),
            Text('Telefon: ${musteri.telefon}',
                style: const TextStyle(fontSize: 18)),
            // Diğer müşteri detaylarını burada ekleyebilirsin
          ],
        ),
      ),
    );
  }
}
