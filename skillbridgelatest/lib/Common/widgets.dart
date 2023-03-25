import 'package:flutter/material.dart';
import 'package:skillbridgelatest/Common/Lists.dart';

class JobTypeView extends StatefulWidget {
  int index;
  JobTypeView(this.index, {super.key});

  @override
  State<JobTypeView> createState() => _JobTypeViewState();
}

class _JobTypeViewState extends State<JobTypeView> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 8,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 219, 217, 217),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
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
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 131, 127, 127)))),
                  child: Text(
                    professionsName[widget.index],
                    style: const TextStyle(
                      color: Color.fromARGB(255, 131, 127, 127),
                      fontSize: 19,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
