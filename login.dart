import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/sabitler/tema.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';
import 'package:yeni_projem/pages/profiles_page.dart';
import 'package:yeni_projem/loginkullanici/register_page.dart';

class GirisSayfasi extends StatefulWidget {
  final KullaniciYonetimi kullaniciYonetimi;

  const GirisSayfasi({super.key, required this.kullaniciYonetimi});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  Tema tema = Tema();
  bool sifreGozukme = false;
  bool beniHatirla = false; // Beni Hatırla checkbox'ı için değişken
  final TextEditingController epostaController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  String? _hataMesaji;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      epostaController.text = prefs.getString('eposta') ?? '';
      sifreController.text = prefs.getString('sifre') ?? '';
      beniHatirla = prefs.getBool('beniHatirla') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('eposta', epostaController.text);
    await prefs.setString('sifre', sifreController.text);
    await prefs.setBool('beniHatirla', beniHatirla);
  }

  void _girisYap() {
    String eposta = epostaController.text;
    String sifre = sifreController.text;

    if (widget.kullaniciYonetimi.girisYap(eposta, sifre)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş başarılı!')),
      );
      if (beniHatirla) {
        _savePreferences();
      }
      // Kullanıcı giriş yaptıktan sonra Profil sayfasına yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            kullaniciYonetimi: widget.kullaniciYonetimi,
            eposta: eposta,
          ),
        ),
      );
    } else {
      setState(() {
        _hataMesaji = 'Geçersiz e-posta veya şifre';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş başarısız!')),
      );
    }
  }

  void _parolaUnuttum() {
    // Parola sıfırlama işlemleri burada yapılabilir
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Parola sıfırlama bağlantısı gönderildi!')),
    );
  }

  void _uyeOl() {
    // Üye Ol butonuna tıklanınca RegisterPage sayfasına yönlendirme
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RegisterPage(kullaniciYonetimi: widget.kullaniciYonetimi),
      ),
    );
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
                    controller: epostaController,
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
                          controller: sifreController,
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
                Row(
                  children: [
                    Checkbox(
                      value: beniHatirla,
                      onChanged: (bool? value) {
                        setState(() {
                          beniHatirla = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Beni Hatırla',
                      style: GoogleFonts.quicksand(color: Colors.white),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _girisYap,
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
                TextButton(
                  onPressed: _parolaUnuttum,
                  child: Text(
                    'Parolanızı mı unuttunuz?',
                    style: GoogleFonts.quicksand(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: _uyeOl,
                  child: Text(
                    'Üye Ol',
                    style: GoogleFonts.quicksand(color: Colors.white),
                  ),
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
