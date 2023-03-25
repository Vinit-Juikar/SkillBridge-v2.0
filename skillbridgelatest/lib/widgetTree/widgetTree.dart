import 'package:flutter/material.dart';

import '../login/firebase/auth.dart';
import 'auth_users.dart';
import 'provider_or_seeker.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AuthUsers();
        } else {
          return const ProviderOrSeeker();
          // return MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   initialRoute: 'information',
          //   routes: {
          //     'information': (context) => const LoginOrRegister(),
          //     'phone': (context) => const MyPhone(),
          //     'verify': (context) => const MyVerify(),
          //   },
          // );
        }
      },
    );
  }
}
