import 'package:flutter/material.dart';
import 'package:hive_bloc/screens/ui/search.dart';
import 'package:hive_bloc/screens/ui/user/history.dart';
import 'package:hive_bloc/screens/ui/user/home.dart';
import 'package:hive_bloc/screens/ui/user/post_question.dart';
import 'package:hive_bloc/screens/ui/user/profile.dart';

class MainHomepage extends StatefulWidget {
  const MainHomepage({super.key});

  @override
  State<MainHomepage> createState() => _HomepageState();
}

class _HomepageState extends State<MainHomepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(
      flag: false,
    ),
    History(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 229, 195, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Search(),
            ),
          );
        },
        child: Icon(
          Icons.search,
        ),
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
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
