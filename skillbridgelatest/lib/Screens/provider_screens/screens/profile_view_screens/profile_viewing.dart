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
  @override
  Widget build(BuildContext context) {
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
                  if (userSnapshot[index]["workType"] == profes) {
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
                                                userSnapshot[index]["id"],
                                                userSnapshot[index]["workType"],
                                                userSnapshot[index]["name"])))
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
                                              userSnapshot[index]["name"],
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
                                                userSnapshot[index]["address"],
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
  String seekerId;
  String work;
  String seekerName;
  JobIcon(this.seekerId, this.work, this.seekerName, {super.key});

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
          createUser(widget.seekerId, widget.work, widget.seekerName);
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

void createUser(String seekerId, String work, String seekerName) async {
  final User? user = Auth().currentUser;
  var number = '';
  number = user?.phoneNumber ?? 'User email';

  //Provider Request
  final providerRequestId =
      FirebaseFirestore.instance.collection('providerRequests').doc();

  final userProfile = UserProfile(
    seekerId: seekerId,
    seekerName: seekerName,
    work: work,
    providerId: number,
    id: providerRequestId.id,
  );
  final json = userProfile.toJson();
  await providerRequestId.set(json);

  //Seeker Update
  final seekId =
      FirebaseFirestore.instance.collection('seekersInformation').doc(seekerId);
  seekId.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      seekId
          .update({
            'RList': FieldValue.arrayUnion([providerRequestId.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Provider Or User Update
  final provid =
      FirebaseFirestore.instance.collection('providerInformation').doc(number);
  provid.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      provid
          .update({
            'SList': FieldValue.arrayUnion([providerRequestId.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
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
