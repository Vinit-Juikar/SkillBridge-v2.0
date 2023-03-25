import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/provider_screens/navbar/provider_navbar.dart';
import '../Screens/seeker_screens/navbar/seeker_navbar.dart';
import '../login/provider/provider_information.dart';
import '../Common/shared_p.dart';
import '../login/seeker/seeker_information.dart';

class AuthUsers extends StatelessWidget {
  const AuthUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDisplayName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return NextScreen(displayName: snapshot.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String> getUserDisplayName() async {
    SharedPreferences prefs = await getSharedPreferencesInstance();
    String myString = prefs.getString('option') ?? '';
    return myString;
  }
}

class NextScreen extends StatelessWidget {
  final String displayName;

  const NextScreen({super.key, required this.displayName});

  @override
  Widget build(BuildContext context) {
    if (displayName == 'seekerLogin') {
      return const SeekerNavbar();
      // return const PatientNavBar();
    } else if (displayName == 'seekerRegister') {
      return const SeekerInformation();
      // return Scaffold(
      //   body: const Center(
      //     child: Text('patientRegister'),
      //   ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Auth().signOut();
      //     },
      //     child: const Icon(Icons.add),
      //   ),
      // );
    } else if (displayName == 'providerLogin') {
      return const ProviderNavbar();
      // return const DoctorNavBar();
    } else {
      return const ProviderInformation();
    }
  }
}
