import 'package:flutter/material.dart';

class StoklarPage extends StatelessWidget {
  const StoklarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stoklar'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Stoklar Sayfası İçeriği'),
      ),
    );
  }
}
