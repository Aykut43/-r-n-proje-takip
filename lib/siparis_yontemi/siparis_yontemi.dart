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

  Map<String, dynamic> toJson() {
    return {
      'urun': urun,
      'miktar': miktar,
      'adres': adres,
      'odeme': odeme,
    };
  }

  factory Siparis.fromJson(Map<String, dynamic> json) {
    return Siparis(
      urun: json['urun'],
      miktar: json['miktar'],
      adres: json['adres'],
      odeme: json['odeme'],
    );
  }
}

class SiparisYonetimi {
  final List<Siparis> _siparisler = [];

  void siparisEkle(Siparis siparis) {
    _siparisler.add(siparis);
  }

  List<Siparis> getSiparisler() {
    return _siparisler;
  }

  void siparisSil(int index) {
    _siparisler.removeAt(index);
  }
}
