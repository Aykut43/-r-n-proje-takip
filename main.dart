import 'package:flutter/material.dart';
import 'package:yeni_projem/pages/home_pagess.dart' as home;
import 'package:yeni_projem/pages/search_page.dart';
import 'package:yeni_projem/pages/profiles_page.dart' as profile;
import 'package:yeni_projem/pages/chat_pages.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/loginkullanici/kullanicilar.dart';

void main() {
  MusteriYonetimi musteriYonetimi = MusteriYonetimi();
  KullaniciYonetimi kullaniciYonetimi = KullaniciYonetimi();

  runApp(MyApp(
      musteriYonetimi: musteriYonetimi, kullaniciYonetimi: kullaniciYonetimi));
}

class MyApp extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;
  final KullaniciYonetimi kullaniciYonetimi;

  const MyApp(
      {super.key,
      required this.musteriYonetimi,
      required this.kullaniciYonetimi});

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
          kullaniciYonetimi: kullaniciYonetimi),
    );
  }
}

class MainPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;
  final KullaniciYonetimi kullaniciYonetimi;

  const MainPage(
      {super.key,
      required this.musteriYonetimi,
      required this.kullaniciYonetimi});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      home.HomePage(musteriYonetimi: widget.musteriYonetimi),
      const SearchPage(),
      ChatPage(musteriYonetimi: widget.musteriYonetimi),
      profile.ProfilePage(
          kullaniciYonetimi: widget.kullaniciYonetimi,
          eposta: "ornek@eposta.com"),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.search),
            label: 'Arama',
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
