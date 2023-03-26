import 'package:flutter/material.dart';
import 'package:skillbridgelatest/Common/shared_p.dart';
import 'package:skillbridgelatest/Screens/provider_screens/profile/provider_profile.dart';
import 'package:skillbridgelatest/Screens/provider_screens/screens/home/job_adding.dart';
import 'package:skillbridgelatest/Screens/provider_screens/screens/profile_view_screens/profile_viewing.dart';
import 'package:skillbridgelatest/login/firebase/auth.dart';
import 'package:skillbridgelatest/widgetTree/widgetTree.dart';

import '../../../../Common/widgets.dart';

class ProviderHomeScreen extends StatelessWidget {
  ProviderHomeScreen({super.key});
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    print('working');
    AddingUserInformation();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProviderProfile(),
                ));
          },
          child: Container(
            child: const Icon(
              Icons.person,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Hello Provider,',
              style: TextStyle(color: Colors.black),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Auth().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WidgetTree(),
                    ),
                    (route) => false);
              },
              child: const Icon(
                Icons.notification_add,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.05,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 215, 250, 16),
                          blurRadius: 10.0),
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    color: Color(0xff1A2270)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/providerAssets/star.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              '\nFeatures: \n 1.Get personalised data \n\n 2.Connect with top priority\n Artisans',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 244, 227, 39)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(180, 60),
                                    backgroundColor: Colors.purple,
                                  ),
                                  child: const Text('Upgrade To Premium')),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              physics: const BouncingScrollPhysics(),
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileViewingScreen(index),
                          ));
                    },
                    child: JobTypeView(index));
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(110, 36, 45, 121),
        onPressed: () {
          // Auth().signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateJob(),
              ));
        },
        child: const Icon(
          Icons.work_outline_outlined,
          size: 28,
        ),
      ),
    );
  }
}
