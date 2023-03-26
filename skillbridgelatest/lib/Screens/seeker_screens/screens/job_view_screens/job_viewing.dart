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

String seekerfName = '';
String seekerlName = '';
String seekerAddress = '';
String seekerImage = '';
String seekerGender = '';

class SeekerInfoRoute extends StatelessWidget {
  var index;
  SeekerInfoRoute(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    String profes = professionsOnFirebase[index].toString();
    var number = '';
    final User? user = Auth().currentUser;
    number = user?.phoneNumber ?? 'dfsfsdfe';
    final providerRef = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}89754321');
    //Provider Request
    providerRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        seekerfName = documentSnapshot.get('fName');
        seekerlName = documentSnapshot.get('lName');
        seekerAddress = documentSnapshot.get('address');
        seekerImage = documentSnapshot.get('image');
        seekerGender = documentSnapshot.get('gender');
        print('');
      } else {
        print('Document does not exist');
      }
    });
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
                                        userSnapshot[index]["id"],
                                        userSnapshot[index]["workType"],
                                        userSnapshot[index]["name"],
                                        userSnapshot[index]["address"],
                                        userSnapshot[index]["image"],
                                        seekerGender,
                                        userSnapshot[index].id,
                                        seekerlName,
                                        seekerfName,
                                        seekerAddress,
                                        seekerImage,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Job Applied")));
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

void createUser(
  String providerid,
  String workType,
  String providerName,
  String providerAddress,
  String providerImage,
  String seekerGender,
  String jobid,
  String seekerlName,
  String seekerfName,
  String seekerAddress,
  String seekerImage,
) async {
  final User? user = Auth().currentUser;
  var number = '';
  number = user?.phoneNumber ?? 'User email';

  final jobRequestRef =
      FirebaseFirestore.instance.collection('jobRequest').doc();

  final seekerRef = FirebaseFirestore.instance
      .collection('userInformation')
      .doc('AKMPVGS${number}89754321');

  final providerRef =
      FirebaseFirestore.instance.collection('userInformation').doc(providerid);
  //Job Profile Update
  final createJobRef =
      FirebaseFirestore.instance.collection('createJob').doc(jobid);

  createJobRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      createJobRef
          .update({
            'recieveList': FieldValue.arrayUnion([jobRequestRef.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Provider Or User Update
  seekerRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      seekerRef
          .update({
            'applyJobList': FieldValue.arrayUnion([jobRequestRef.id]),
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Seeker Notification Update
  providerRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      providerRef
          .update({
            'notification': FieldValue.arrayUnion([
              {
                'requestid': createJobRef.id,
                'id': 'AKMPVGS${number}89754321',
                'type': 'job',
                'name': '$seekerfName $seekerlName',
                'workType': workType,
              }
            ]),
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });
  await jobRequestRef.set({
    'id': jobRequestRef.id,
    'jobid': jobid,
    'providerid': providerid,
    'seekerid': 'AKMPVGS${number}89754321',
    'seekerName': '$seekerfName $seekerlName',
    'providerName': providerName,
    'seekerAddress': seekerAddress,
    'providerAddress': providerAddress,
    'seekerGender': seekerGender,
    'workType': workType,
    'applicationStatus': 'Offer Sent',
    'seekerImage': seekerImage,
    'providerImage': providerImage,
  });
}
