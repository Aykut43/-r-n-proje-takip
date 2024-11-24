import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';

class SiparislerPage extends StatefulWidget {
  final SiparisYonetimi siparisYonetimi;

  const SiparislerPage({super.key, required this.siparisYonetimi});

  @override
  SiparislerPageState createState() => SiparislerPageState();
}

class SiparislerPageState extends State<SiparislerPage> {
  late SharedPreferences _prefs;
  List<Siparis> _siparisler = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final siparisListString = _prefs.getString('siparisler') ?? '[]';
    final siparisListJson =
        List<Map<String, dynamic>>.from(json.decode(siparisListString));
    setState(() {
      _siparisler =
          siparisListJson.map((json) => Siparis.fromJson(json)).toList();
    });
  }

  Future<void> _savePreferences() async {
    final siparisList = _siparisler.map((siparis) => siparis.toJson()).toList();
    await _prefs.setString('siparisler', json.encode(siparisList));
  }

  void _siparisSil(BuildContext context, int index) {
    setState(() {
      widget.siparisYonetimi.siparisSil(index);
      _siparisler = widget.siparisYonetimi.getSiparisler();
      _savePreferences();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sipariş silindi')),
    );
  }

  void _siparisGuncelle(BuildContext context, int index) {
    // Sipariş güncelleme işlemleri burada yapılabilir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişler'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _siparisler.length,
          itemBuilder: (context, index) {
            final siparis = _siparisler[index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(siparis.urun),
                subtitle: Text(
                    'Miktar: ${siparis.miktar}\nAdres: ${siparis.adres}\nÖdeme Yöntemi: ${siparis.odeme}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _siparisGuncelle(context, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _siparisSil(context, index),
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
