import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/pages/urunlerim.dart'; // Urunlerim dosyasını içe aktardık

class StoklarPage extends StatelessWidget {
  const StoklarPage({super.key});

  void _urunSil(BuildContext context, int index) {
    if (index >= 0 && index < UrunlerimPage.urunler.length) {
      UrunlerimPage.urunler.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ürün silindi')),
      );
      _saveUrunler();
    }
  }

  void _urunGuncelle(BuildContext context, int index) {
    // Ürün güncelleme işlemleri burada yapılabilir
  }

  void _saveUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> urunlerString = UrunlerimPage.urunler.map((urun) {
      return urun.entries.map((e) => '${e.key}:${e.value}').join(',');
    }).toList();
    prefs.setStringList('urunler', urunlerString);
  }

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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _urunGuncelle(context, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _urunSil(context, index),
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
