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
            title: Text(musteri.ad),
            onTap: () {
              Navigator.pop(context, musteri.ad);
            },
          );
        },
      ),
    );
  }
}
