import 'package:flutter/material.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: const Center(
        child: Text('Ana Sayfaya Hoşgeldiniz!'),
      ),
    );
  }
}
