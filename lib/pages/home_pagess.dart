import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/SiparisYonetimi/siparis_yonetimi.dart'; // Dosya adını güncelledik
import 'package:yeni_projem/pages/stoklar.dart'; // Stoklar sayfasını içe aktardık
import 'package:yeni_projem/pages/urunlerim.dart'; // Ürünlerim sayfasını içe aktardık
import 'package:yeni_projem/pages/siparis_olustur.dart'; // Sipariş Oluştur sayfasını içe aktardık
import 'package:yeni_projem/pages/siparisler.dart'; // Siparişler sayfasını içe aktardık
import 'package:yeni_projem/pages/musteri_kaydi.dart'; // Müşteri Kaydı sayfasını içe aktardık
import 'package:yeni_projem/pages/musteri_listesi.dart'; // Müşteri Listesi sayfasını içe aktardık

class HomePage extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;
  final SiparisYonetimi siparisYonetimi =
      SiparisYonetimi(); // SiparisYonetimi nesnesini oluşturduk

  HomePage({super.key, required this.musteriYonetimi});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Bildirimler için işlem
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Arka plan rengi beyaz
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity, // Yanlara kadar doldur
                decoration: BoxDecoration(
                  color: Colors.green, // Kutu rengi yeşil
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Dualtron PopularPop scooter ',
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Icon(
                      Icons.trending_up,
                      color: Colors.white, // İkon rengi beyaz
                      size: 32.0,
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
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
                            builder: (context) => const UrunlerimPage()),
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
                                musteriYonetimi: musteriYonetimi)),
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
                                musteriYonetimi: musteriYonetimi)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
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
