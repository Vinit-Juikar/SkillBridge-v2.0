import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillbridgelatest/widgetTree/widgetTree.dart';

import '../../../login/firebase/auth.dart';

String fName = '';
String lName = '';
String Address = '';
String image = '';
String gender = '';

class SeekerProfileScreen extends StatelessWidget {
  SeekerProfileScreen({super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'dfsfsdfe';
    final providerRef = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}89754321');
    //Provider Request
    providerRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        fName = documentSnapshot.get('fName');
        lName = documentSnapshot.get('lName');
        Address = documentSnapshot.get('address');
        image = documentSnapshot.get('image');
        gender = documentSnapshot.get('gender');

        print('');
      } else {
        print('Document does not exist');
      }
    });
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        border: Border.all(
                            color: const Color.fromARGB(100, 23, 140, 166)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 250,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color:
                                            Color.fromARGB(100, 23, 140, 166),
                                        width: 2))),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 23, 140, 166),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                // child: Image.asset(
                                //   userSnapshot[index]["gender"] ==
                                //           'male'
                                //       ? 'assets/workMen.jpeg'
                                //       : 'assets/workWmn.jpg',
                                //   fit: BoxFit.cover,
                                //   height: MediaQuery.of(context)
                                //           .size
                                //           .width /
                                //       2.3,
                                //   width: MediaQuery.of(context)
                                //           .size
                                //           .width /
                                //       2.3,
                                // ),
                                child: Image.network(
                                  image,
                                  // 'userSnapsho',
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.width / 2.5,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'DM Sans'),
                                      ),
                                      Text(
                                        '$fName $lName',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'DM Sans'),
                                      ),
                                      Text(
                                        gender == 'male' ? 'Male' : 'Female',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'DM Sans'),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        child: Text(
                                          Address,
                                          // overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey,
                                              fontFamily: 'DM Sans'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Phone',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'DM Sans'),
                                      ),
                                      Text(
                                        number,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
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

class SeekerProfile extends StatelessWidget {
  const SeekerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'dfsfsdfe';
    final providerRef = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}89754321');
    //Provider Request
    providerRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        fName = documentSnapshot.get('fName');
        lName = documentSnapshot.get('lName');
        Address = documentSnapshot.get('address');
        image = documentSnapshot.get('image');
        gender = documentSnapshot.get('gender');

        print('');
      } else {
        print('Document does not exist');
      }
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 23, 140, 166),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: Row(
          children: const [
            Spacer(
              flex: 4,
            ),
            Text(
              'Profile',
              style: TextStyle(
                  color: Color.fromARGB(255, 23, 140, 166), fontSize: 25),
            ),
            Spacer(
              flex: 6,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SeekerProfileScreen(),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Auth().signOut();

                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Log Out")));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WidgetTree(),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                color: Colors.grey,
                child: Row(
                  children: const [
                    Text(
                      'SignOut  ',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
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
