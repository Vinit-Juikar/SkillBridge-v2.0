import 'package:flutter/material.dart';

import '../../../../Common/widgets.dart';
import '../profile_view_screens/dummy.dart';
import 'send_provider_request.dart';

class RequestsProvider extends StatelessWidget {
  const RequestsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // final User? user = Auth().currentUser;
    // var number = '';
    // number = user?.phoneNumber ?? 'User email';
    // CollectionReference users =
    //     FirebaseFirestore.instance.collection('providerInformation');
    // DocumentReference docRef = users.doc(number);
    // docRef.get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     myList = documentSnapshot.get('SList');
    //     print(myList);
    //   } else {}
    // });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                  ),
                  child: Text(
                    'Recieve',
                    style: TextStyle(color: Colors.black),
                  )),
              Tab(
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                  child: Text(
                    'Sent',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          title: const Text(
            'Request',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const TabBarView(
          children: [RecieveRequestProviderOptions(), SendProviderRequests()],
        ),
      ),
    );
  }
}

class RecieveRequestProviderOptions extends StatelessWidget {
  const RecieveRequestProviderOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    ));
  }
}
