class Musteri {
  final String ad;
  final String soyad;
  final String tckn;
  final String vn;
  final String adres;
  final String telefon;
  final String sirketAdi;

  Musteri({
    required this.ad,
    required this.soyad,
    required this.tckn,
    required this.vn,
    required this.adres,
    required this.telefon,
    required this.sirketAdi,
  });
}

class MusteriYonetimi {
  final List<Musteri> _musteriler = [];

  List<Musteri> getMusteriler() {
    return _musteriler;
  }

  void musteriEkle(Musteri musteri) {
    _musteriler.add(musteri);
  }

  void musteriSil(Musteri musteri) {
    _musteriler.remove(musteri);
  }
}
