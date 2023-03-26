import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/firebase/auth.dart';

Future<SharedPreferences> getSharedPreferencesInstance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

var providerfName;
var providerlName;
var providerAddress;
var providerImage;
void AddingUserInformation() async {
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
  SharedPreferences prefs = await getSharedPreferencesInstance();
  prefs.setString('fName', providerfName);
  prefs.setString('lName', providerlName);
  prefs.setString('address', providerAddress);
  prefs.setString('image', providerImage);
  print(prefs.getString('fName'));
}
