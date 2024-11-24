import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';
import 'package:yeni_projem/loginkullanici/login.dart'; // GirisSayfasi sınıfını içe aktardık

class LogoutPage extends StatelessWidget {
  final KullaniciYonetimi kullaniciYonetimi;

  const LogoutPage({super.key, required this.kullaniciYonetimi});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oturumu Kapat'),
          content: const Text('Oturumu kapatmak istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          GirisSayfasi(kullaniciYonetimi: kullaniciYonetimi)),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oturumu Kapat'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _logout(context),
          child: const Text('Oturumu Kapat'),
        ),
      ),
    );
  }
}
