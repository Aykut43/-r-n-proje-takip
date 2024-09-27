import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takip_sistemi/sabitler/tema.dart';
import 'package:takip_sistemi/home/home_page.dart';
import 'package:logger/logger.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  Tema tema = Tema();
  bool sifreGozukme = false;
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    logger.d('Şifre Gözüktü mü: $sifreGozukme');
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
                      Icons.login,
                      size: 50,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Giriş Yapın",
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
                    decoration: tema.inputDec(
                      "E-Posta Adresinizi Girin...",
                      Icons.people_alt_outlined,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin: const EdgeInsets.only(
                      top: 7.5, bottom: 30, right: 30, left: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: sifreGozukme,
                          decoration: tema.inputDec(
                            "Şifrenizi Girin...",
                            Icons.vpn_key_off_outlined,
                          ),
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              sifreGozukme = !sifreGozukme;
                            });
                          },
                          icon: Icon(
                            sifreGozukme
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      logger.d("TIKLANDI");
                    }
                    // Kullanıcı giriş yaptıktan sonra AnaSayfa'ya yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnaSayfa()),
                    );
                  },
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
                          'GİRİŞ YAP',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
