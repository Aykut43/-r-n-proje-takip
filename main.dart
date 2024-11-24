import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeni_projem/pages/home_pagess.dart' as home;
import 'package:yeni_projem/pages/profiles_page.dart' as profile;
import 'package:yeni_projem/pages/chat_pages.dart';
import 'package:yeni_projem/pages/calender.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';
import 'package:yeni_projem/siparis_yontemi/siparis_yontemi.dart';

void main() {
  MusteriYonetimi musteriYonetimi = MusteriYonetimi();
  KullaniciYonetimi kullaniciYonetimi = KullaniciYonetimi();
  SiparisYonetimi siparisYonetimi = SiparisYonetimi();

  runApp(MyApp(
      musteriYonetimi: musteriYonetimi,
      kullaniciYonetimi: kullaniciYonetimi,
      siparisYonetimi: siparisYonetimi));
}

class MyApp extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;
  final KullaniciYonetimi kullaniciYonetimi;
  final SiparisYonetimi siparisYonetimi;

  const MyApp(
      {super.key,
      required this.musteriYonetimi,
      required this.kullaniciYonetimi,
      required this.siparisYonetimi});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ofis Yönetimi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(
          musteriYonetimi: musteriYonetimi,
          kullaniciYonetimi: kullaniciYonetimi,
          siparisYonetimi: siparisYonetimi),
    );
  }
}

class MainPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;
  final KullaniciYonetimi kullaniciYonetimi;
  final SiparisYonetimi siparisYonetimi;

  const MainPage(
      {super.key,
      required this.musteriYonetimi,
      required this.kullaniciYonetimi,
      required this.siparisYonetimi});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
    _widgetOptions = <Widget>[
      home.HomePage(
          musteriYonetimi: widget.musteriYonetimi,
          siparisYonetimi: widget.siparisYonetimi),
      const CalendarPage(), // Takvim sayfasını ekledik
      ChatPage(musteriYonetimi: widget.musteriYonetimi),
      profile.ProfilePage(
          kullaniciYonetimi: widget.kullaniciYonetimi,
          eposta: "ornek@eposta.com"),
    ];
  }

  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  Future<void> _saveSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _saveSelectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Takvim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mesajlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
