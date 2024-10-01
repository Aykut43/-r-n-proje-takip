import 'package:flutter/material.dart';
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';

class SiparislerPage extends StatelessWidget {
  final SiparisYonetimi siparisYonetimi;

  const SiparislerPage({super.key, required this.siparisYonetimi});

  @override
  Widget build(BuildContext context) {
    final siparisler = siparisYonetimi.getSiparisler();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişler'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: siparisler.length,
          itemBuilder: (context, index) {
            final siparis = siparisler[index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(siparis.urun),
                subtitle: Text(
                    'Miktar: ${siparis.miktar}\nAdres: ${siparis.adres}\nÖdeme Yöntemi: ${siparis.odeme}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
