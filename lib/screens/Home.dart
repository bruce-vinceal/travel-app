import 'package:flutter/material.dart';
import 'package:travel_app/screens/Dashboard.dart';
import 'package:travel_app/screens/Profile.dart';
import 'package:travel_app/screens/Search.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    Search(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile"
        ),
      ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}