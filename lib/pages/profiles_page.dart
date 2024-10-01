import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';
import 'package:yeni_projem/loginkullanici/logout.dart';

class ProfilePage extends StatelessWidget {
  final KullaniciYonetimi kullaniciYonetimi;
  final String eposta;

  const ProfilePage(
      {super.key, required this.kullaniciYonetimi, required this.eposta});

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bizim Hakkımızda'),
          content: const Text(
              'Bu uygulama, kullanıcıların ofis yönetimini kolaylaştırmak için geliştirilmiştir.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? kullaniciAdi = kullaniciYonetimi.kullaniciAdiAl(eposta);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Sayfası',
          style: GoogleFonts.quicksand(
            color: Colors.black, // Başlık yazısı siyah
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false, // Geri butonunu kaldırmak için
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'logout') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LogoutPage(kullaniciYonetimi: kullaniciYonetimi)),
                );
              } else if (result == 'about') {
                _showAboutDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Oturumu Kapat'),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('Bizim Hakkımızda'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                //backgroundImage:
                //AssetImage('assets/profile_picture.png'), // Profil resmi
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                kullaniciAdi ?? 'Kullanıcı Adı',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                eposta,
                style: GoogleFonts.quicksand(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(), // Boşluk bırakmak için Spacer widget'ı ekledik
            Text(
              'Hakkında',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Bu alanda kullanıcı hakkında bilgiler yer alabilir. Örneğin, biyografi, ilgi alanları, vb.',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'İletişim Bilgileri',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Telefon: +90 123 456 7890',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            Text(
              'Adres: İstanbul, Türkiye',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
