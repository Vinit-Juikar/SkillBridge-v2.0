import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillbridgelatest/Screens/seeker_screens/screens/job_view_screens/job_viewing.dart';
import 'package:skillbridgelatest/widgetTree/widgetTree.dart';

import '../../../../Common/Lists.dart';
import '../../../../login/firebase/auth.dart';
import '../../../../login/seeker/select_profile.dart';

List vara = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

class SeekerHomeScreen extends StatelessWidget {
  const SeekerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = user?.phoneNumber ?? '9876543210';
    final docref = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}89754321');
    docref.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        fName = documentSnapshot.get('fName');
        vara[0] = documentSnapshot.get('createdProfile.carpenter');
        vara[1] = documentSnapshot.get('createdProfile.electrician');
        vara[2] = documentSnapshot.get('createdProfile.electronic repairs');
        vara[3] = documentSnapshot.get('createdProfile.house maid');
        vara[4] = documentSnapshot.get('createdProfile.locksmith');
        vara[5] = documentSnapshot.get('createdProfile.mechanic');
        vara[6] = documentSnapshot.get('createdProfile.painter');
        vara[7] = documentSnapshot.get('createdProfile.plumber');
        vara[8] = documentSnapshot.get('createdProfile.tile setter');
        vara[9] = documentSnapshot.get('createdProfile.welder');
        print(vara);
      } else {
        print('Document does not exist');
      }
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Row(
          children: const [
            Text(
              'Hello Seeker,',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            Icon(
              Icons.notification_add,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const AdSection(),
          JobViewSection(),
          const CurrentCustomers(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WidgetTree(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CurrentCustomers extends StatelessWidget {
  const CurrentCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 500,
    );
  }
}

class JobViewSection extends StatelessWidget {
  JobViewSection({super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.5,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      if (vara[index]) {
                        return JobTypeViewT(index);
                      } else {
                        return const SizedBox();
                      }
                    }),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class JobTypeViewT extends StatefulWidget {
  int index;
  JobTypeViewT(this.index, {super.key});

  @override
  State<JobTypeViewT> createState() => _JobTypeViewTState();
}

class _JobTypeViewTState extends State<JobTypeViewT> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeekerInfoRoute(widget.index),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 8,
          child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 235, 235),
                border: Border.all(
                  color: const Color.fromARGB(255, 219, 217, 217),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(professionsImages[widget.index]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 131, 127, 127)))),
                      child: Text(
                        professionsName[widget.index],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 131, 127, 127),
                          fontSize: 19,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class AdSection extends StatelessWidget {
  const AdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 250,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 200,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 126, 210, 252)),
                      color: const Color.fromARGB(255, 161, 219, 247)),
                  height: 220,
                  width: MediaQuery.of(context).size.width / 1.1,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 120,
                              child: const Text(
                                  'More Opportunities to explore in electronic sector'),
                            ),
                            Container(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text("Apply Now")),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        'assets/images/ac_repairer.jpeg',
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
