import 'package:flutter/material.dart';
import 'package:vidloader/views/search.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Vidloader",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff014bf4),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_sharp,
                  color: Colors.white,
                ),
                onPressed: (() {
                  // go to download page
                }),
              ))
        ],
      ),
      body: Container(
        child: const [
          Center(
            child: Search(),
          ),
          Center(
            child: Text(
              'Unlearn 🐛',
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
