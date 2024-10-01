class Kullanici {
  final String eposta;
  final String sifre;
  final String kullaniciAdi;

  Kullanici(
      {required this.eposta, required this.sifre, required this.kullaniciAdi});
}

class KullaniciYonetimi {
  final List<Kullanici> _kullanicilar = [];

  void kullaniciEkle(Kullanici kullanici) {
    _kullanicilar.add(kullanici);
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
}
