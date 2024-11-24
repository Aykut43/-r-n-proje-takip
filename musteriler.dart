import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Musteri {
  String ad;
  String soyad;
  String tckn;
  String vn;
  String adres;
  String telefon;
  String sirketAdi;
  String? eposta;
  String? dogumTarihi;

  Musteri({
    required this.ad,
    required this.soyad,
    required this.tckn,
    required this.vn,
    required this.adres,
    required this.telefon,
    required this.sirketAdi,
    this.eposta,
    this.dogumTarihi,
  });

  Map<String, dynamic> toJson() {
    return {
      'ad': ad,
      'soyad': soyad,
      'tckn': tckn,
      'vn': vn,
      'adres': adres,
      'telefon': telefon,
      'sirketAdi': sirketAdi,
      'eposta': eposta,
      'dogumTarihi': dogumTarihi,
    };
  }

  factory Musteri.fromJson(Map<String, dynamic> json) {
    return Musteri(
      ad: json['ad'],
      soyad: json['soyad'],
      tckn: json['tckn'],
      vn: json['vn'],
      adres: json['adres'],
      telefon: json['telefon'],
      sirketAdi: json['sirketAdi'],
      eposta: json['eposta'],
      dogumTarihi: json['dogumTarihi'],
    );
  }
}

class MusteriYonetimi {
  List<Musteri> _musteriler = [];

  List<Musteri> getMusteriler() {
    return _musteriler;
  }

  Future<void> musteriEkle(Musteri musteri) async {
    _musteriler.add(musteri);
    await _saveMusteriler();
  }

  Future<void> musteriSil(Musteri musteri) async {
    _musteriler.remove(musteri);
    await _saveMusteriler();
  }

  bool musteriGuncelle(Musteri musteri) {
    for (var m in _musteriler) {
      if (m.tckn == musteri.tckn) {
        m.ad = musteri.ad;
        m.soyad = musteri.soyad;
        m.adres = musteri.adres;
        m.telefon = musteri.telefon;
        m.sirketAdi = musteri.sirketAdi;
        m.eposta = musteri.eposta;
        m.dogumTarihi = musteri.dogumTarihi;
        _saveMusteriler();
        return true;
      }
    }
    return false;
  }

  Future<void> _saveMusteriler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> musterilerString = _musteriler.map((musteri) {
      return json.encode(musteri.toJson());
    }).toList();
    await prefs.setStringList('musteriler', musterilerString);
  }

  Future<void> loadMusteriler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? musterilerString = prefs.getStringList('musteriler');
    if (musterilerString != null) {
      _musteriler = musterilerString.map((musteriString) {
        Map<String, dynamic> musteriMap =
            json.decode(musteriString) as Map<String, dynamic>;
        return Musteri.fromJson(musteriMap);
      }).toList();
    }
  }
}
