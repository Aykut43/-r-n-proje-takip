import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/pages/siparis_olustur_page.dart'; // Dosya adını güncelledik
import 'package:yeni_projem/pages/stoklar.dart'; // Stoklar sayfasını içe aktardık
import 'package:yeni_projem/pages/urunlerim.dart'; // Ürünlerim sayfasını içe aktardık
import 'package:yeni_projem/pages/siparisler.dart'; // Siparişler sayfasını içe aktardık
import 'package:yeni_projem/pages/musteri_kaydi.dart'; // Müşteri Kaydı sayfasını içe aktardık
import 'package:yeni_projem/pages/musteri_listesi.dart'; // Müşteri Listesi sayfasını içe aktardık
import 'package:yeni_projem/pages/search_page.dart'; // Search sayfasını içe aktardık
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';

class HomePage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const HomePage({super.key, required this.musteriYonetimi});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final SiparisYonetimi siparisYonetimi =
      SiparisYonetimi(); // SiparisYonetimi nesnesini oluşturduk
  late SharedPreferences _prefs;
  String? _storedValue;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = _prefs.getString('storedValue') ?? 'Varsayılan Değer';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AFS Müşteri Takip',
          style: GoogleFonts.quicksand(
            color: Colors.black, // Başlık yazısı siyah
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false, // Geri butonunu kaldırmak için
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Bildirimler için işlem
            },
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                    builder: (context) => const SearchPage(query: ''),
                  ),
                );
              },
            ),
            // Diğer menü öğeleri buraya eklenebilir
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // Arka plan rengi beyaz
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ara...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (query) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(query: query),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kısa Yollar',
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Kaydedilen Değer: $_storedValue',
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3, // 3 sütunlu grid
                        children: [
                          _buildGridButton(
                            context,
                            'Ürünlerim',
                            Icons.inventory, // Güzel bir ikon ekledik
                            Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UrunlerimPage()),
                              );
                            },
                          ),
                          _buildGridButton(
                            context,
                            'Sipariş Oluştur',
                            Icons.add_shopping_cart,
                            Colors.green,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SiparisOlusturPage(
                                        musteriYonetimi: widget.musteriYonetimi,
                                        siparisYonetimi: siparisYonetimi)),
                              );
                            },
                          ),
                          _buildGridButton(
                            context,
                            'Stoklar',
                            Icons.storage,
                            Colors.orange,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StoklarPage()),
                              );
                            },
                          ),
                          _buildGridButton(
                            context,
                            'Müşteri Kaydı',
                            Icons.people,
                            Colors.purple,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MusteriKaydiPage(
                                        musteriYonetimi:
                                            widget.musteriYonetimi)),
                              );
                            },
                          ),
                          _buildGridButton(
                            context,
                            'Siparişler',
                            Icons.list,
                            Colors.red,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SiparislerPage(
                                        siparisYonetimi: siparisYonetimi)),
                              );
                            },
                          ),
                          _buildGridButton(
                            context,
                            'Müşteriler',
                            Icons.people_alt,
                            Colors.teal,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MusteriListesiPage(
                                        musteriYonetimi:
                                            widget.musteriYonetimi)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(
      BuildContext context, String title, IconData icon, Color color,
      {VoidCallback? onTap}) {
    return Card(
      color: Colors.grey[200], // Koyu beyaz renk
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 48.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
