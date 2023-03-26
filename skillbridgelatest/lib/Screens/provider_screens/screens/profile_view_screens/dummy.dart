import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillbridgelatest/Common/Lists.dart';

import '../../../../login/firebase/auth.dart';

List work = [
  "Carpenter",
  "Electrician",
  "Electronic_repaireres",
  "house_maid",
  "locksmith",
  "Mechanic",
  "Painter",
  "plumber",
  "Tile_setter",
  "Welder"
];

class ProfileViewingScreen extends StatefulWidget {
  var index;
  ProfileViewingScreen(this.index, {super.key});

  @override
  State<ProfileViewingScreen> createState() => _ProfileViewingScreenState();
}

class _ProfileViewingScreenState extends State<ProfileViewingScreen> {
  bool rated = false;
  String providerfName = '';
  String providerlName = '';
  String providerAddress = '';
  String providerImage = '';
  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'dfsfsdfe';
    final providerRef = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}897543210');
    //Provider Request
    providerRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        providerfName = documentSnapshot.get('fName');
        providerlName = documentSnapshot.get('lName');
        providerAddress = documentSnapshot.get('address');
        providerImage = documentSnapshot.get('image');
        print('');
      } else {
        print('Document does not exist');
      }
    });

    String profes = professionsOnFirebase[widget.index].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Text(
                profes,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            GestureDetector(
              onTap: () {
                rated = !rated;
                setState(() {});
              },
              child: Container(
                width: 130,
                height: 30,
                decoration: BoxDecoration(
                    border: !rated
                        ? Border.all(
                            color: const Color.fromARGB(255, 23, 140, 166))
                        : Border.all(color: Colors.white),
                    color: rated
                        ? const Color.fromARGB(255, 23, 140, 166)
                        : Colors.white),
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: rated
                          ? Colors.white
                          : const Color.fromARGB(255, 23, 140, 166),
                    ),
                    Text(
                      rated ? 'Sorted By Rating' : ' Sort By Rating',
                      style: TextStyle(
                          fontSize: 13,
                          color: rated
                              ? Colors.white
                              : const Color.fromARGB(255, 23, 140, 166)),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: rated
              ? FirebaseFirestore.instance
                  .collection("jobProfile")
                  .orderBy('rating', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance.collection("jobProfile").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final userSnapshot = snapshot.data?.docs;
            if (userSnapshot!.isEmpty) {
              return const Center(child: Text("no data"));
            }
            return ListView.builder(
                itemCount: userSnapshot.length,
                itemBuilder: (context, index) {
                  if (userSnapshot[index]["workType"] == profes.toString()) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // color: Colors.amber,
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(100, 23, 140, 166)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 250,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  100, 23, 140, 166),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                          userSnapshot[index]['image']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: JobIcon(
                                          userSnapshot[index]['id'].toString(),
                                          userSnapshot[index]['workType']
                                              .toString(),
                                          userSnapshot[index]['name']
                                              .toString(),
                                          userSnapshot[index]['address']
                                              .toString(),
                                          providerfName.toString(),
                                          providerlName.toString(),
                                          providerAddress.toString(),
                                          providerImage.toString(),
                                          userSnapshot[index]['image']
                                              .toString(),
                                          userSnapshot[index]['gender']
                                              .toString(),
                                          userSnapshot[index].id.toString(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  height: 100,
                                  thickness: 5,
                                  color: Colors.black,
                                ),
                                Container(
                                  height: 250,
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'DM Sans'),
                                            ),
                                            Text(
                                              userSnapshot[index]["name"]
                                                  .toString(),
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
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Gender',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'DM Sans'),
                                                ),
                                                Text(
                                                  userSnapshot[index]
                                                              ["gender"] ==
                                                          'male'
                                                      ? 'Male'
                                                      : 'Female',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                      fontFamily: 'DM Sans'),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Rating',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'DM Sans'),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      userSnapshot[index]
                                                              ["rating"]
                                                          .toStringAsFixed(1),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey,
                                                          fontFamily:
                                                              'DM Sans'),
                                                    ),
                                                    const Icon(
                                                      Icons.star_border_rounded,
                                                      color: Color.fromARGB(
                                                          255, 206, 186, 7),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'DM Sans'),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              child: Text(
                                                userSnapshot[index]["address"]
                                                    .toString(),
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
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Phone',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'DM Sans'),
                                            ),
                                            Text(
                                              "+91 ${userSnapshot[index]["id"].toString().substring(10, 20)}",
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
                    );
                  } else {
                    return const Center();
                  }
                });
          },
        ),
      ),
    );
  }
}

class JobIcon extends StatefulWidget {
  String seekerid;
  String workType;
  String seekerName;
  String seekerAddress;
  String seekerImage;
  String seekerGender;
  String providerlName;
  String providerfName;
  String providerAddress;
  String providerImage;
  String profileid;
  JobIcon(
      this.seekerid,
      this.workType,
      this.seekerName,
      this.seekerAddress,
      this.providerfName,
      this.providerlName,
      this.providerAddress,
      this.providerImage,
      this.seekerImage,
      this.seekerGender,
      this.profileid,
      {super.key});

  @override
  State<JobIcon> createState() => _JobIconState();
}

class _JobIconState extends State<JobIcon> {
  bool have = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (have) {
          createUser(
            widget.seekerid,
            widget.workType,
            widget.seekerName,
            widget.seekerAddress,
            widget.seekerImage,
            widget.seekerGender,
            widget.profileid,
            widget.providerfName,
            widget.providerlName,
            widget.providerAddress,
            widget.providerImage,
          );
        }
        have = !have;
        setState(() {});
      },
      child: Material(
        elevation: have ? 8 : 0,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: have
                ? const Color.fromARGB(255, 217, 217, 217)
                : const Color.fromARGB(255, 23, 140, 166),
          ),
          height: 45,
          width: MediaQuery.of(context).size.width / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  have ? Icons.shopping_bag_outlined : Icons.send,
                  size: 32,
                  color: !have
                      ? Colors.white
                      : const Color.fromARGB(255, 23, 140, 166),
                ),
                Text(
                  have ? 'Send Offer' : 'Offer Sent',
                  style: TextStyle(
                    fontSize: 19,
                    color: !have
                        ? Colors.white
                        : const Color.fromARGB(255, 23, 140, 166),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void createUser(
  String seekerid,
  String workType,
  String seekerName,
  String seekerAddress,
  String seekerImage,
  String seekerGender,
  String profileid,
  String providerlName,
  String providerfName,
  String providerAddress,
  String providerImage,
) async {
  final User? user = Auth().currentUser;
  var number = '';
  number = user?.phoneNumber ?? 'User email';

  final hireRequestRef =
      FirebaseFirestore.instance.collection('hireRequest').doc();

  final providerRef = FirebaseFirestore.instance
      .collection('userInformation')
      .doc('AKMPVGS${number}897543210');

  final seekerRef =
      FirebaseFirestore.instance.collection('userInformation').doc(seekerid);
  //Job Profile Update
  final jobProfileRef =
      FirebaseFirestore.instance.collection('jobProfile').doc(profileid);
  jobProfileRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      jobProfileRef
          .update({
            'recieveList': FieldValue.arrayUnion([hireRequestRef.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Provider Or User Update
  providerRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      providerRef
          .update({
            'hiringApplicantList': FieldValue.arrayUnion([hireRequestRef.id]),
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Seeker Notification Update
  seekerRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      providerRef
          .update({
            'notification': FieldValue.arrayUnion([
              {
                'hireRequest': hireRequestRef.id,
                'providerid': 'AKMPVGS${number}897543210',
                'providerName': '$providerfName $providerlName',
                'workType': workType,
              }
            ]),
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });
  await hireRequestRef.set({
    'id': hireRequestRef.id,
    'profileid': profileid,
    'seekerid': seekerid,
    'providerid': 'AKMPVGS${number}897543210',
    'providerName': '$providerfName $providerlName',
    'seekerName': seekerName,
    'seekerAddress': seekerAddress,
    'providerAddress': providerAddress,
    'seekerGender': seekerGender,
    'workType': workType,
    'applicationStatus': 'Offer Sent',
    'seekerImage': seekerImage,
    'providerImage': providerImage,
  });
}

class UserProfile {
  final String seekerId;
  final String seekerName;
  final String work;
  final String providerId;
  final String id;

  UserProfile({
    required this.seekerId,
    required this.seekerName,
    required this.work,
    required this.providerId,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'seekerId': seekerId,
        'seekerName': seekerName,
        'work': work,
        'providerId': providerId,
      };
}
