import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/rendering/sliver_staggered_grid.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

class exploreProviderHomeScreen extends StatefulWidget {
  const exploreProviderHomeScreen({super.key});

  @override
  State<exploreProviderHomeScreen> createState() =>
      _exploreProviderHomeScreenState();
}

class _exploreProviderHomeScreenState extends State<exploreProviderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 4, 69),
        title: const AnimatedDefaultTextStyle(
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          duration: Duration(milliseconds: 500),
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
      'assets/Explore/1.jpg',
      'assets/Explore/2.png',
      'assets/Explore/3.jpg',
      'assets/Explore/4.jpeg',
      'assets/Explore/5.jpg',
      'assets/Explore/6.jpg',
      'assets/Explore/7.webp',
      'assets/Explore/8.png',
      'assets/Explore/9.jpg',
      'assets/Explore/10.jpg',
      'assets/Explore/11.png',
      'assets/Explore/12.jpg',
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
                  color: const Color.fromARGB(255, 152, 157, 250),
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
                      const SizedBox(height: 16),
                      Text(
                        'Image ${i + 1}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                      const SizedBox(height: 16),
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
                margin: const EdgeInsets.all(2),
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

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 2, crossAxisCount: 2),
      children: children,
    );
  }
}
