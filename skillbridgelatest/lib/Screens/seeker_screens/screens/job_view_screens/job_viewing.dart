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

class SeekerInfoRoute extends StatelessWidget {
  var index;
  SeekerInfoRoute(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    String profes = professionsOnFirebase[index].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          profes,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("createJob").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final userSnapshot = snapshot.data?.docs;
          if (userSnapshot!.isEmpty) {
            return const Text("no data");
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
                              color: const Color.fromARGB(96, 158, 158, 158)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 1.8,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 30,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.centerLeft,
                                      child: Text(userSnapshot[index]["name"]
                                          .toString()),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 30,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.contain,
                                      child: Text("Address: " +
                                          userSnapshot[index]["address"]),
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 30,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.contain,
                                      child: Text(
                                          "Phone: +91 ${userSnapshot[index]["id"].toString().substring(10, 20)}"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      createUser(
                                          userSnapshot[index]['id'],
                                          userSnapshot[index]['workType'],
                                          userSnapshot[index]['name']);
                                    },
                                    child: const Text(
                                      'Apply Now',
                                      style: TextStyle(fontSize: 17),
                                    )))
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center();
                }
              });
        },
      )),
    );
  }
}

void createUser(String providerIdd, String work, String providerName) async {
  final User? user = Auth().currentUser;
  var number = '';
  number = user?.phoneNumber ?? 'User email';

  //Provider Request
  final providerRequestId =
      FirebaseFirestore.instance.collection('seekerRequests').doc();

  final userProfile = UserProfile(
    providerId: providerIdd,
    providerName: providerName,
    work: work,
    seekerId: number,
    id: providerRequestId.id,
  );
  final json = userProfile.toJson();
  await providerRequestId.set(json);

  //Provider Update
  final seekId = FirebaseFirestore.instance
      .collection('seekersInformation')
      .doc(providerIdd);
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

  //Seeker Or User Update
  final provid =
      FirebaseFirestore.instance.collection('seekersInformation').doc(number);
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
  final String providerId;
  final String providerName;
  final String work;
  final String seekerId;
  final String id;

  UserProfile({
    required this.providerId,
    required this.providerName,
    required this.work,
    required this.seekerId,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'providerId': providerId,
        'providerName': providerName,
        'work': work,
        'seekerId': seekerId,
      };
}
