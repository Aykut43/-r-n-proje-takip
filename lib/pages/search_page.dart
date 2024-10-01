import 'package:flutter/material.dart';
import 'urunlerim.dart'; // UrunlerimPage sayfasını içe aktar

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = UrunlerimPage.urunler.where((urun) {
      return urun['isim']!.toLowerCase().contains(_searchQuery.toLowerCase());
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
                    // Müşteri arama sonuçlarını burada listeleyebilirsin
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
