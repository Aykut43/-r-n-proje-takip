import 'package:flutter/material.dart';
import 'urunlerim.dart'; // UrunlerimPage sayfasını içe aktar
import 'package:yeni_projem/loginkullanici/musteriler.dart'; // MusteriYonetimi sınıfını içe aktar

class SearchPage extends StatefulWidget {
  final String query; // query parametresini ekledik

  const SearchPage(
      {super.key, required this.query}); // query parametresini ekledik

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  final MusteriYonetimi musteriYonetimi =
      MusteriYonetimi(); // MusteriYonetimi nesnesini oluşturduk

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.query; // query parametresini _searchQuery'ye atadık
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = UrunlerimPage.urunler.where((urun) {
      return urun['isim']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final filteredCustomers = musteriYonetimi.getMusteriler().where((musteri) {
      return musteri.ad.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          musteri.soyad.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          musteri.sirketAdi.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arama Sayfası'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Arama',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (_searchQuery.isNotEmpty) ...[
                    ListTile(
                      title: const Text('Ürün Arama Sonuçları'),
                      subtitle: Text('Aranan: $_searchQuery'),
                    ),
                    ...filteredProducts.map((urun) => ListTile(
                          title: Text(urun['isim']!),
                          subtitle: Text(urun['fiyat']!),
                        )),
                    ListTile(
                      title: const Text('Müşteri Arama Sonuçları'),
                      subtitle: Text('Aranan: $_searchQuery'),
                    ),
                    ...filteredCustomers.map((musteri) => ListTile(
                          title: Text('${musteri.ad} ${musteri.soyad}'),
                          subtitle: Text(musteri.sirketAdi),
                        )),
                  ] else ...[
                    const Center(
                      child: Text('Arama yapmak için bir şeyler yazın'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
