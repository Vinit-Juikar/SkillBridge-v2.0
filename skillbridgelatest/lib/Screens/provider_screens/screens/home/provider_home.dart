import 'package:flutter/material.dart';

import '../../../../login/firebase/auth.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Text('Hello there,'), Icon(Icons.notification_add)],
        ),
      ),
      body: const Center(
        child: Text('Provider HomeScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
