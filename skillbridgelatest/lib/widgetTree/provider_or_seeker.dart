import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../login/provider/provider_phone.dart';
import '../login/provider/provider_login_or_register.dart';
import '../login/provider/provider_verify.dart';
import '../login/seeker/login_or_register.dart';
import '../login/seeker/seeker_phone.dart';
import '../login/seeker/seeker_verify.dart';

String choosedOption = '';
bool provider = true;
bool seeker = true;

class ProviderOrSeeker extends StatelessWidget {
  const ProviderOrSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    provider = true;
    seeker = true;
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Lottie.asset('assets/login/docOrpatient.json', height: 300),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromARGB(150, 85, 93, 229),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome !!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Now it is easier to connect seekers to providers \nthrough a tap on the screen ',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Choose',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ChoiceChips(),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (provider == true && seeker == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Choose One Option")));
                              return;
                            } else if (!provider) {
                              choosedOption = 'provider';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const providersLoginScreens(),
                                ),
                              );
                            } else {
                              choosedOption = 'seeker';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const seekersLoginScreens(),
                                ),
                              );
                            }
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 85, 93, 229)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key});

  @override
  State<ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ChoiceChip(
          avatar: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/login/provider_select.jpg')),
          elevation: 2,
          padding: const EdgeInsets.all(4),
          label: Text(
            'Provider',
            style: TextStyle(
                color: provider ? Colors.black : Colors.white, fontSize: 23),
          ),
          backgroundColor:
              provider ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: provider,
          onSelected: (newboolvalue) {
            provider = !provider;
            seeker = true;
            setState(() {});
          },
        ),
        ChoiceChip(
          avatar: Image.asset(
            'assets/login/seeker_select.webp',
          ),
          elevation: 2,
          label: Text(
            'Seeker',
            style: TextStyle(
                color: seeker ? Colors.black : Colors.white, fontSize: 23),
          ),
          backgroundColor:
              seeker ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: seeker,
          onSelected: (newboolvalue) {
            seeker = !seeker;
            provider = true;
            setState(() {});
          },
        ),
      ],
    );
  }
}

class providersLoginScreens extends StatelessWidget {
  const providersLoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'information',
      routes: {
        'information': (context) => const ProviderLoginOrRegister(),
        'phone': (context) => const ProviderPhone(),
        'verify': (context) => const ProviderVerify(),
      },
    );
  }
}

class seekersLoginScreens extends StatelessWidget {
  const seekersLoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'information',
      routes: {
        'information': (context) => const LoginOrRegister(),
        'phone': (context) => const SeekerPhone(),
        'verify': (context) => const SeekerVerify(),
      },
    );
  }
}
