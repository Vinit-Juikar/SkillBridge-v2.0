import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Lists.dart';
import '../../Common/shared_p.dart';
import '../../Screens/seeker_screens/navbar/seeker_navbar.dart';
import '../firebase/auth.dart';

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
// bool carpenter = false;
// bool electrician = false;
// bool electronic_repairs = false;
// bool house_maid = false;
// bool locksmith = false;
// bool mechanic = false;
// bool painter = false;
// bool plumber = false;
// bool tile_settler = false;
// bool welder = false;

var fName;
var address;
var gender;
var lName;
var image;

class SelectProfile extends StatelessWidget {
  const SelectProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = user?.phoneNumber ?? '9876543210';
    for (var i = 0; i < 10; i++) {
      vara[i] = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
            ),
          ),
        ),
        title: const Text(
          'Professions',
          style: TextStyle(
              color: Color.fromARGB(255, 117, 117, 117), fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              physics: const BouncingScrollPhysics(),
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return JobProfileView(index);
              }),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                '   Select Profile   ',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () async {
                if (vara[0] == true ||
                    vara[1] == true ||
                    vara[2] == true ||
                    vara[3] == true ||
                    vara[4] == true ||
                    vara[5] == true ||
                    vara[6] == true ||
                    vara[7] == true ||
                    vara[8] == true ||
                    vara[9] == true) {
                  print(vara);
                  selectProfileNow(number);
                  SharedPreferences prefs =
                      await getSharedPreferencesInstance();
                  prefs.setString('option', 'seekerLogin');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SeekerNavbar(),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Choose One Option")));
                  return;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class JobProfileView extends StatefulWidget {
  int index;
  JobProfileView(this.index, {super.key});

  @override
  State<JobProfileView> createState() => _JobProfileViewState();
}

class _JobProfileViewState extends State<JobProfileView> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        vara[widget.index] = !vara[widget.index];
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 8,
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: vara[widget.index]
                      ? Colors.green
                      : const Color.fromARGB(255, 219, 217, 217),
                  width: vara[widget.index] ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width / 2,
              height: 105,
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
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 2,
                                  color: vara[widget.index]
                                      ? Colors.green
                                      : const Color.fromARGB(
                                          255, 131, 127, 127)))),
                      child: Text(
                        professionsName[widget.index],
                        style: TextStyle(
                          color: vara[widget.index]
                              ? Colors.green
                              : const Color.fromARGB(255, 131, 127, 127),
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

void selectProfileNow(String number) async {
  print('Implementing');
  final docref = FirebaseFirestore.instance
      .collection('userInformation')
      .doc('AKMPVGS${number}89754321');
  docref.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      fName = documentSnapshot.get('fName');
      address = documentSnapshot.get('address');
      gender = documentSnapshot.get('gender');
      lName = documentSnapshot.get('lName');
      image = documentSnapshot.get('image');
    } else {
      print('Document does not exist');
    }
  });
  for (var i = 0; i < 10; i++) {
    String proffes = professionsOnFirebase[i];
    if (vara[i]) {
      final carpJob = FirebaseFirestore.instance.collection('jobProfile').doc();
      await docref.update({
        'createdProfile.$proffes': true,
      });
      await docref.update({
        'createProfile.$proffes': {'id': carpJob.id}
      });
      await carpJob.set({
        'id': 'AKMPVGS${number}89754321',
        'name': fName + ' ' + lName,
        'address': address,
        'gender': gender,
        'workType': proffes,
        'image': image,
        'rating': 5.0,
        'ratingList': [],
        'recieveList': [],
        'goingApplication': []
      });
    }
  }
}
