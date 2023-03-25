import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            // color: Colors.amber,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: double.infinity,
            // color: Color.fromARGB(255, 247, 249, 248),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Material(
                    shadowColor: Color.fromARGB(255, 49, 46, 46),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 5, 17, 23))),
                          color: Color.fromARGB(255, 175, 230, 242),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.black)),
                              child: Image.asset(
                                "assets/images/mechanic.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 5, 17, 23))),
                          color: Color.fromARGB(255, 175, 230, 242),
                        ),
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Column(
                          children: [
                            Text('\n'),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    Name',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    Aarushi Kadam',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Text('\n'),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    Age',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    24 Years',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Text('\n'),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    Address',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                '    Sector 3, \n    Kharghar, Navi \n    Mumbai',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
