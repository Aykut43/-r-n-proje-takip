import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_projem/pages/urunlerim.dart';
import 'package:yeni_projem/pages/siparisler.dart';
import 'package:yeni_projem/pages/stoklar.dart';
import 'package:yeni_projem/pages/musteri_kaydi.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';
import 'package:yeni_projem/pages/search_page.dart';
import 'package:yeni_projem/pages/siparis_olustur_page.dart'; // SiparisOlusturPage dosyasını içe aktardık

import 'musteri_listesi.dart';

class HomePage extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;
  final SiparisYonetimi siparisYonetimi;

  const HomePage(
      {super.key,
      required this.musteriYonetimi,
      required this.siparisYonetimi});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          'AFS Müşteri Takip',
          style: GoogleFonts.quicksand(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Bildirim sayfasına yönlendirme işlemleri burada yapılabilir
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Ara...',
                        hintStyle: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (query) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(query: query)),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Ana Sayfa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Arama'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage(query: '')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                // Ayarlar sayfasına yönlendirme işlemleri burada yapılabilir
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              Text(
                'Kısa Yollar',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 400, // Belirli bir yükseklik verin
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildGridItem(
                      context,
                      'Ürünlerim',
                      Icons.shopping_bag,
                      Colors.blue,
                      UrunlerimPage(),
                    ),
                    _buildGridItem(
                      context,
                      'Sipariş Oluştur',
                      Icons.add_shopping_cart,
                      Colors.green,
                      SiparisOlusturPage(
                        musteriYonetimi: musteriYonetimi,
                        siparisYonetimi: siparisYonetimi,
                      ), // SiparisOlusturPage sayfasına yönlendirme
                    ),
                    _buildGridItem(
                      context,
                      'Stoklar',
                      Icons.inventory,
                      Colors.orange,
                      StoklarPage(),
                    ),
                    _buildGridItem(
                      context,
                      'Müşteri Kaydı',
                      Icons.person,
                      Colors.red,
                      MusteriKaydiPage(musteriYonetimi: musteriYonetimi),
                    ),
                    _buildGridItem(
                      context,
                      'Siparişler',
                      Icons.flag,
                      Colors.purple,
                      SiparislerPage(siparisYonetimi: siparisYonetimi),
                    ),
                    _buildGridItem(
                      context,
                      'Müşteriler',
                      Icons.people,
                      Colors.brown,
                      MusterilerPage(musteriYonetimi: musteriYonetimi),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Butonların içini gri yap
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color), // Butonların boyutunu küçült
            const SizedBox(height: 8.0),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 16, // Yazıların boyutunu küçült
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
