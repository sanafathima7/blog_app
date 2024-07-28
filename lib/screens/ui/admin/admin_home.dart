import 'package:flutter/material.dart';
import 'package:hive_bloc/screens/ui/admin/admin_homepage.dart';
import 'package:hive_bloc/screens/ui/admin/admin_user.dart';
import 'package:hive_bloc/screens/ui/admin/admin_verification.dart';
import 'package:hive_bloc/screens/ui/search.dart';

class AdminMainHomepage extends StatefulWidget {
  AdminMainHomepage({super.key, required this.flag});
  bool flag;

  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminMainHomepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminHomepage(
      flag: false,
    ),
    AdminVerification(),
    AdminUserList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 229, 195, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Search(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.verified), label: 'Verify'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'User'),
        ],
      ),
    );
  }
}
