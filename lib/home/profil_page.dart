import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: const Center(
        child: Text(
          'Bu Profil Sayfasıdır',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}