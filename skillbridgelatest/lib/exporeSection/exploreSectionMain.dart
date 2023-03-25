import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class exploreProviderHomeScreen extends StatefulWidget {
  const exploreProviderHomeScreen({super.key});

  @override
  State<exploreProviderHomeScreen> createState() =>
      _exploreProviderHomeScreenState();
}

class _exploreProviderHomeScreenState extends State<exploreProviderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 4, 69),
        title: AnimatedDefaultTextStyle(
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Text('Self Learn'),
        ),
      ),
      body: Container(
        child: masonryLayout(context),
      ),
    );
  }

  Widget masonryLayout(BuildContext context) {
    List imagesList = [
      'assets/1.jpg',
      'assets/2.png',
      'assets/3.jpg',
      'assets/4.jpeg',
      'assets/5.jpg',
      'assets/6.jpg',
      'assets/7.webp',
      'assets/8.png',
      'assets/9.jpg',
      'assets/10.jpg',
      'assets/11.png',
      'assets/12.jpg',
    ];

    List<Widget> children = [];
    for (int i = 0; i < imagesList.length; i++) {
      children.add(
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              // backgroundColor: Colors.blue,
              context: context,
              builder: (_) {
                return Container(
                  color: Color.fromARGB(255, 152, 157, 250),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'image$i',
                          child: Image.asset(
                            imagesList[i],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Image ${i + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                );
              },
            );
          },
          child: Hero(
            tag: 'image$i',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  imagesList[i % 12].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return MasonryGridView(
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: children,
    );
  }
}
