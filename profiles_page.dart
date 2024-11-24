import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';
import 'package:yeni_projem/loginkullanici/login.dart'; // GirisSayfasi sınıfını import ettik

class ProfilePage extends StatefulWidget {
  final KullaniciYonetimi kullaniciYonetimi;
  final String eposta;

  const ProfilePage(
      {super.key, required this.kullaniciYonetimi, required this.eposta});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile_image.png';
    if (File(path).existsSync()) {
      setState(() {
        _profileImagePath = path;
      });
    }
  }

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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oturumu Kapat'),
          content: const Text('Oturumu kapatmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Oturumu kapatma işlemi burada yapılabilir
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GirisSayfasi(
                          kullaniciYonetimi: widget.kullaniciYonetimi)),
                );
              },
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/profile_image.png';
      final file = File(pickedFile.path);
      await file.copy(path);

      setState(() {
        _profileImagePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? kullaniciAdi =
        widget.kullaniciYonetimi.kullaniciAdiAl(widget.eposta);

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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showAboutDialog(context); // Ayarlar sayfasına yönlendirme
            },
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    backgroundImage: _profileImagePath != null
                        ? FileImage(File(_profileImagePath!))
                        : null,
                    child: _profileImagePath == null
                        ? const Text(
                            'AS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
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
                widget.eposta,
                style: GoogleFonts.quicksand(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Hesap',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Hesap sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Text(
                'Gizlilik & Güvenlik',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Gizlilik & Güvenlik sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Text(
                'Genel',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Genel sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Text(
                'Lisanslar',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Lisanslar sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Text(
                'Yardım',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Yardım sayfasına yönlendirme
              },
            ),
            ListTile(
              title: Text(
                'İletişim',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // İletişim sayfasına yönlendirme
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Oturumu Kapat',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
