import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class UrunlerimPage extends StatefulWidget {
  const UrunlerimPage({super.key});

  static List<Map<String, dynamic>> urunler = [];

  @override
  UrunlerimPageState createState() => UrunlerimPageState();
}

class UrunlerimPageState extends State<UrunlerimPage> {
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadUrunler();
  }

  void _loadUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? urunlerString = prefs.getStringList('urunler');
    if (urunlerString != null) {
      setState(() {
        UrunlerimPage.urunler = urunlerString.map((urun) {
          Map<String, dynamic> urunMap = {};
          urun.split(',').forEach((element) {
            List<String> keyValue = element.split(':');
            if (keyValue.length == 2) {
              urunMap[keyValue[0]] = keyValue[1];
            }
          });
          return urunMap;
        }).toList();
      });
    }
  }

  void _saveUrunler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> urunlerString = UrunlerimPage.urunler.map((urun) {
      return urun.entries.map((e) => '${e.key}:${e.value}').join(',');
    }).toList();
    prefs.setStringList('urunler', urunlerString);
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _urunEkle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController isimController = TextEditingController();
        final TextEditingController fiyatController = TextEditingController();
        final TextEditingController adetController = TextEditingController();
        return AlertDialog(
          title: const Text('Ürün Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: isimController,
                  decoration: const InputDecoration(labelText: 'Ürün İsmi'),
                ),
                TextField(
                  controller: fiyatController,
                  decoration: const InputDecoration(labelText: 'Fiyat (₺)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue.copyWith(text: '');
                      }

                      final int value = int.parse(newValue.text);
                      final String newText =
                          '₺${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

                      return newValue.copyWith(
                        text: newText,
                        selection:
                            TextSelection.collapsed(offset: newText.length),
                      );
                    }),
                  ],
                ),
                TextField(
                  controller: adetController,
                  decoration: const InputDecoration(labelText: 'Adet'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: const Text('Fotoğraf Çek'),
                ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: const Text('Galeriden Seç'),
                ),
                if (imagePath != null)
                  Image.file(
                    File(imagePath!),
                    height: 50,
                    width: 50,
                  ),
              ],
            ),
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
                  UrunlerimPage.urunler.add({
                    'isim': isimController.text,
                    'fiyat': fiyatController.text,
                    'adet': int.parse(adetController.text),
                    'resim': imagePath ?? '',
                  });
                  _saveUrunler();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  void _urunGuncelle(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController isimController =
            TextEditingController(text: UrunlerimPage.urunler[index]['isim']);
        final TextEditingController fiyatController =
            TextEditingController(text: UrunlerimPage.urunler[index]['fiyat']);
        final TextEditingController adetController = TextEditingController(
            text: UrunlerimPage.urunler[index]['adet'].toString());
        return AlertDialog(
          title: const Text('Ürünü Güncelle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: isimController,
                  decoration: const InputDecoration(labelText: 'Ürün İsmi'),
                ),
                TextField(
                  controller: fiyatController,
                  decoration: const InputDecoration(labelText: 'Fiyat (₺)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue.copyWith(text: '');
                      }

                      final int value = int.parse(newValue.text);
                      final String newText =
                          '₺${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

                      return newValue.copyWith(
                        text: newText,
                        selection:
                            TextSelection.collapsed(offset: newText.length),
                      );
                    }),
                  ],
                ),
                TextField(
                  controller: adetController,
                  decoration: const InputDecoration(labelText: 'Adet'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: const Text('Fotoğraf Çek'),
                ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: const Text('Galeriden Seç'),
                ),
                if (imagePath != null)
                  Image.file(
                    File(imagePath!),
                    height: 50,
                    width: 50,
                  ),
              ],
            ),
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
                  UrunlerimPage.urunler[index] = {
                    'isim': isimController.text,
                    'fiyat': fiyatController.text,
                    'adet': int.parse(adetController.text),
                    'resim': imagePath ?? UrunlerimPage.urunler[index]['resim'],
                  };
                  _saveUrunler();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Güncelle'),
            ),
          ],
        );
      },
    );
  }

  void _urunSil(int index) {
    setState(() {
      UrunlerimPage.urunler.removeAt(index);
      _saveUrunler();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ürün silindi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final urunler = UrunlerimPage.urunler;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünlerim'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _urunEkle,
          ),
          PopupMenuButton<int>(
            onSelected: (index) {
              // Seçilen ürünü güncelle veya sil
              _urunGuncelle(index);
              // _urunSil(index) fonksiyonunu çağırmak isterseniz buraya ekleyebilirsiniz
            },
            itemBuilder: (context) {
              return List.generate(urunler.length, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text(urunler[index]['isim']),
                );
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: urunler.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: urunler.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Ürün düzenleme veya silme işlemi için AppBar'daki eylemleri kullanacağız.
                      // Mevcut ürünü düzenlemek veya silmek için app bar butonlarına göre index'i geçebiliriz.
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (urunler[index]['resim'] != null &&
                                urunler[index]['resim']!.isNotEmpty)
                              Image.file(
                                File(urunler[index]['resim']!),
                                height: 50,
                                width: 50,
                              ),
                            const SizedBox(height: 8.0),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                urunler[index]['isim']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                urunler[index]['fiyat']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Adet: ${urunler[index]['adet']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'Henüz ürün eklemediniz.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
      ),
    );
  }
}
