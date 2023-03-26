import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../login/firebase/auth.dart';

import '../../../../Common/Lists.dart';

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
var createProf;

class RecieveSeekerRequestScreen extends StatelessWidget {
  RecieveSeekerRequestScreen({super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = user?.phoneNumber ?? '9876543210';
    final docref = FirebaseFirestore.instance
        .collection('userInformation')
        .doc('AKMPVGS${number}89754321');
    docref.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
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

        createProf = documentSnapshot.get('createProfile');
        // createProf[1] = documentSnapshot.get('createProfile.electrician');
        // createProf[2] =
        //     documentSnapshot.get('createProfile.electronic repairs');
        // createProf[3] = documentSnapshot.get('createProfile.house maid');
        // createProf[4] = documentSnapshot.get('createProfile.locksmith');
        // createProf[5] = documentSnapshot.get('createProfile.mechanic');
        // createProf[6] = documentSnapshot.get('createProfile.painter');
        // createProf[7] = documentSnapshot.get('createProfile.plumber');
        // createProf[8] = documentSnapshot.get('createProfile.tile setter');
        // createProf[9] = documentSnapshot.get('createProfile.welder');
        print(createProf);
        print(vara);
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
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      String profe = professionsOnFirebase[index];
                      print('Working');
                      if (vara[index]) {
                        String id = createProf[profe]['id'];
                        return JobTypeViewW(index, id);
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

class JobTypeViewW extends StatefulWidget {
  int index;
  var id;
  JobTypeViewW(this.index, this.id, {super.key});

  @override
  State<JobTypeViewW> createState() => _JobTypeViewWState();
}

class _JobTypeViewWState extends State<JobTypeViewW> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    print('id : ' + widget.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecieveSeekerRequestScaff(widget.id),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
              height: 150,
              width: double.infinity,
              child: Row(
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
                          fontSize: 24,
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

class RecieveSeekerRequestScaff extends StatelessWidget {
  var id;
  RecieveSeekerRequestScaff(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
      ),
      body: SafeArea(child: RecieveSeekerRequests(id)),
    );
  }
}

class RecieveSeekerRequests extends StatefulWidget {
  var id;
  RecieveSeekerRequests(this.id, {super.key});

  @override
  State<RecieveSeekerRequests> createState() => _RecieveSeekerRequestsState();
}

class _RecieveSeekerRequestsState extends State<RecieveSeekerRequests> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    var myList = [];
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'User email';
    CollectionReference users =
        FirebaseFirestore.instance.collection('jobProfile');
    DocumentReference docRef = users.doc(widget.id);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        myList = documentSnapshot.get('recieveList');
        print(myList);
      } else {}
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
              Expanded(
                child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecieveRequestFormat(myList[index]);
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

class RecieveRequestFormat extends StatefulWidget {
  var providerRequestId;
  RecieveRequestFormat(this.providerRequestId, {super.key});

  @override
  State<RecieveRequestFormat> createState() => _RecieveRequestFormatState();
}

class _RecieveRequestFormatState extends State<RecieveRequestFormat> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    var providerId = '';
    var workType = '';
    var image = '';
    var name = '';
    CollectionReference users =
        FirebaseFirestore.instance.collection('hireRequest');
    DocumentReference docRef = users.doc(widget.providerRequestId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        providerId = documentSnapshot.get('providerid');
        workType = documentSnapshot.get('workType');
        image = documentSnapshot.get('providerImage');
        name = documentSnapshot.get('providerName');
      } else {}
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(image),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            const Text(
                              'Name:',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            const Spacer(),
                            const Text(
                              'Work Type:',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              workType,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            const Spacer(),
                            const Text(
                              'Phone No.:',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '+91${providerId.substring(10, 20)}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
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

class WithSeekerData extends StatefulWidget {
  var seekerId;
  WithSeekerData(this.seekerId, {super.key});

  @override
  State<WithSeekerData> createState() => _WithSeekerDataState();
}

class _WithSeekerDataState extends State<WithSeekerData> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    var name = '';
    var gender = '';
    var work = '';
    CollectionReference users =
        FirebaseFirestore.instance.collection('seekersInformation');
    DocumentReference docRef = users.doc(widget.seekerId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get('name');
        gender = documentSnapshot.get('gender');
        work = documentSnapshot.get('work');
      } else {}
    });
    return FutureBuilder<String>(
      future: _calculation, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(gender == 'female'
                              ? 'assets/workWmn.jpg'
                              : 'assets/workMen.jpeg'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            'Name: $name',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          Text(
                            'Gender: $gender',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          Text(
                            'Work: $work',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
