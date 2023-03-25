import 'package:flutter/material.dart';

import '../../../../login/firebase/auth.dart';

class SeekerHomeScreen extends StatelessWidget {
  const SeekerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Text('Hello there,'), Icon(Icons.notification_add)],
        ),
      ),
      body: const Center(
        child: Text('Seeker HomeScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const SeekerInformation(),
          //     ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
