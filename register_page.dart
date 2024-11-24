import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_projem/sabitler/tema.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';

class RegisterPage extends StatefulWidget {
  final KullaniciYonetimi kullaniciYonetimi;

  const RegisterPage({super.key, required this.kullaniciYonetimi});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Tema tema = Tema();
  final TextEditingController epostaController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController kullaniciAdiController = TextEditingController();
  String? _hataMesaji;

  void _kayitOl() {
    String eposta = epostaController.text;
    String sifre = sifreController.text;
    String kullaniciAdi = kullaniciAdiController.text;

    if (eposta.isNotEmpty && sifre.isNotEmpty && kullaniciAdi.isNotEmpty) {
      widget.kullaniciYonetimi.kullaniciEkle(
        Kullanici(eposta: eposta, sifre: sifre, kullaniciAdi: kullaniciAdi),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt başarılı!')),
      );
      Navigator.pop(context);
    } else {
      setState(() {
        _hataMesaji = 'Lütfen tüm alanları doldurun';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt başarısız!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 111, 111, 111)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.black,
                        width: 15,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 50,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Üye Ol",
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin: const EdgeInsets.only(
                      top: 40, bottom: 10, right: 30, left: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextFormField(
                    controller: kullaniciAdiController,
                    decoration: tema.inputDec(
                      "Kullanıcı Adınızı Girin...",
                      Icons.person,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 30, left: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextFormField(
                    controller: epostaController,
                    decoration: tema.inputDec(
                      "E-Posta Adresinizi Girin...",
                      Icons.email,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 30, right: 30, left: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextFormField(
                    controller: sifreController,
                    obscureText: true,
                    decoration: tema.inputDec(
                      "Şifrenizi Girin...",
                      Icons.lock,
                    ),
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _kayitOl,
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.blue,
                            Color.fromARGB(255, 132, 189, 236)
                          ]),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 3),
                                blurRadius: 5)
                          ]),
                      child: Center(
                        child: Text(
                          'KAYIT OL',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
                if (_hataMesaji != null)
                  Center(
                    child: Text(
                      _hataMesaji!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
