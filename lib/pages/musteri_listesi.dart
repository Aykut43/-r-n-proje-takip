import 'dart:convert'; // Bu satırı ekleyin
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';

class MusteriListesiPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const MusteriListesiPage({super.key, required this.musteriYonetimi});

  @override
  MusteriListesiPageState createState() => MusteriListesiPageState();
}

class MusteriListesiPageState extends State<MusteriListesiPage> {
  late SharedPreferences _prefs;
  List<Musteri> _musteriler = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final musteriListString = _prefs.getString('musteriler') ?? '[]';
    final musteriListJson =
        List<Map<String, dynamic>>.from(json.decode(musteriListString));
    setState(() {
      _musteriler =
          musteriListJson.map((json) => Musteri.fromJson(json)).toList();
    });
  }

  Future<void> _savePreferences() async {
    final musteriList = _musteriler.map((musteri) => musteri.toJson()).toList();
    await _prefs.setString('musteriler', json.encode(musteriList));
  }

  @override
  Widget build(BuildContext context) {
    final musteriler = widget.musteriYonetimi.getMusteriler();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Listesi'),
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
                      // Müşteri güncelleme işlemleri burada yapılabilir
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await widget.musteriYonetimi.musteriSil(musteri);
                      setState(() {
                        _musteriler = widget.musteriYonetimi.getMusteriler();
                        _savePreferences();
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
}
