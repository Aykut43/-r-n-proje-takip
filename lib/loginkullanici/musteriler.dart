import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Bu satırı ekleyin

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

  bool musteriGuncelle(String tckn,
      {String? yeniAd,
      String? yeniSoyad,
      String? yeniAdres,
      String? yeniTelefon,
      String? yeniSirketAdi,
      String? yeniEposta,
      String? yeniDogumTarihi}) {
    for (var musteri in _musteriler) {
      if (musteri.tckn == tckn) {
        if (yeniAd != null) musteri.ad = yeniAd;
        if (yeniSoyad != null) musteri.soyad = yeniSoyad;
        if (yeniAdres != null) musteri.adres = yeniAdres;
        if (yeniTelefon != null) musteri.telefon = yeniTelefon;
        if (yeniSirketAdi != null) musteri.sirketAdi = yeniSirketAdi;
        if (yeniEposta != null) musteri.eposta = yeniEposta;
        if (yeniDogumTarihi != null) musteri.dogumTarihi = yeniDogumTarihi;
        _saveMusteriler();
        return true;
      }
    }
    return false;
  }

  Future<void> _saveMusteriler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> musterilerString = _musteriler.map((musteri) {
      return musteri.toJson().toString();
    }).toList();
    prefs.setStringList('musteriler', musterilerString);
  }

  Future<void> loadMusteriler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? musterilerString = prefs.getStringList('musteriler');
    if (musterilerString != null) {
      _musteriler = musterilerString.map((musteriString) {
        Map<String, dynamic> musteriMap =
            Map<String, dynamic>.from(json.decode(musteriString));
        return Musteri.fromJson(musteriMap);
      }).toList();
    }
  }
}
