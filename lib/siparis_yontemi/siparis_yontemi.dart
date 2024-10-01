class Siparis {
  final String urun;
  final String miktar;
  final String adres;
  final String odeme;

  Siparis({
    required this.urun,
    required this.miktar,
    required this.adres,
    required this.odeme,
  });
}

class SiparisYonetimi {
  final List<Siparis> _siparisler = [];

  void siparisEkle(Siparis siparis) {
    _siparisler.add(siparis);
  }

  List<Siparis> getSiparisler() {
    return _siparisler;
  }
}
