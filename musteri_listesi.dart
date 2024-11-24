import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';

class MusterilerPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const MusterilerPage({super.key, required this.musteriYonetimi});

  @override
  MusterilerPageState createState() => MusterilerPageState();
}

class MusterilerPageState extends State<MusterilerPage> {
  @override
  Widget build(BuildContext context) {
    final musteriler = widget.musteriYonetimi.getMusteriler();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteriler'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: musteriler.length,
        itemBuilder: (context, index) {
          final musteri = musteriler[index];
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text('${musteri.ad} ${musteri.soyad}'),
              subtitle: Text(musteri.sirketAdi),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context, musteri);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.musteriYonetimi.musteriSil(musteri);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Musteri musteri) {
    final TextEditingController adController =
        TextEditingController(text: musteri.ad);
    final TextEditingController soyadController =
        TextEditingController(text: musteri.soyad);
    final TextEditingController sirketAdiController =
        TextEditingController(text: musteri.sirketAdi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Müşteri Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: adController,
                decoration: const InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                controller: soyadController,
                decoration: const InputDecoration(labelText: 'Soyad'),
              ),
              TextField(
                controller: sirketAdiController,
                decoration: const InputDecoration(labelText: 'Şirket Adı'),
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
                  musteri.ad = adController.text;
                  musteri.soyad = soyadController.text;
                  musteri.sirketAdi = sirketAdiController.text;
                  widget.musteriYonetimi.musteriGuncelle(musteri);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
