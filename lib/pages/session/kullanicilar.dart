class Kullanici {
  String eposta;
  String sifre;

  Kullanici({required this.eposta, required this.sifre});
}

class KullaniciYonetimi {
  List<Kullanici> kullanicilar = [];

  void kullaniciEkle(String eposta, String sifre) {
    kullanicilar.add(Kullanici(eposta: eposta, sifre: sifre));
  }

  bool girisYap(String eposta, String sifre) {
    for (var kullanici in kullanicilar) {
      if (kullanici.eposta == eposta && kullanici.sifre == sifre) {
        return true;
      }
    }
    return false;
  }
}
