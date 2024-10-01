import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';

class ChatPage extends StatelessWidget {
  final MusteriYonetimi musteriYonetimi;

  const ChatPage({super.key, required this.musteriYonetimi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlar'),
      ),
      body: const Center(
        child: Text('Mesajlar sayfası'),
      ),
    );
  }
}
