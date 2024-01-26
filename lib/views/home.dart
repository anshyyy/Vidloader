import 'package:flutter/material.dart';
import 'package:vidloader/views/search.dart';

import 'downloads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: [
          const Center(
            child: Search(),
          ),
          Center(
            child: DownloadPage(
              fileUrl: '',
            ),
          ),
        ][selectedPageIndex],
      ),
      bottomNavigationBar: Container(
        child: NavigationBar(
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Downloads',
            ),
          ],
        ),
      ),
    );
  }
}
