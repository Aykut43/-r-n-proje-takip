import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Kullanici {
  final String eposta;
  final String sifre;
  final String kullaniciAdi;

  Kullanici(
      {required this.eposta, required this.sifre, required this.kullaniciAdi});

  Map<String, dynamic> toJson() {
    return {
      'eposta': eposta,
      'sifre': sifre,
      'kullaniciAdi': kullaniciAdi,
    };
  }

  factory Kullanici.fromJson(Map<String, dynamic> json) {
    return Kullanici(
      eposta: json['eposta'],
      sifre: json['sifre'],
      kullaniciAdi: json['kullaniciAdi'],
    );
  }
}

class KullaniciYonetimi {
  final List<Kullanici> _kullanicilar = [];

  void kullaniciEkle(Kullanici kullanici) {
    _kullanicilar.add(kullanici);
    _saveKullanicilar();
  }

  String? kullaniciAdiAl(String eposta) {
    for (var kullanici in _kullanicilar) {
      if (kullanici.eposta == eposta) {
        return kullanici.kullaniciAdi;
      }
    }
    return null;
  }

  bool girisYap(String eposta, String sifre) {
    for (var kullanici in _kullanicilar) {
      if (kullanici.eposta == eposta && kullanici.sifre == sifre) {
        return true;
      }
    }
    return false;
  }

  Future<void> _saveKullanicilar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> kullanicilarString = _kullanicilar.map((kullanici) {
      return kullanici.toJson().toString();
    }).toList();
    prefs.setStringList('kullanicilar', kullanicilarString);
  }

  Future<void> loadKullanicilar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? kullanicilarString = prefs.getStringList('kullanicilar');
    if (kullanicilarString != null) {
      _kullanicilar.clear();
      _kullanicilar.addAll(kullanicilarString.map((kullaniciString) {
        Map<String, dynamic> kullaniciMap =
            Map<String, dynamic>.from(json.decode(kullaniciString));
        return Kullanici.fromJson(kullaniciMap);
      }).toList());
    }
  }
}
