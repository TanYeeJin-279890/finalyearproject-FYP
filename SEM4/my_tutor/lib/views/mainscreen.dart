import 'package:flutter/material.dart';
import '../models/reg.dart';
import 'subjectList.dart';
import 'tutor.dart';

class MainScreen extends StatefulWidget {
  final Registration reg;
  const MainScreen({Key? key, required this.reg}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectIdx = 0;
  late List<Widget> _pages;

  void _onTapped(int index) {
    setState(() {
      _selectIdx = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      SubjectList(reg: widget.reg),
      const TutorPage(),
      const Text(
        'Subscribe',
      ),
      const Text(
        'Favourite',
      ),
      const Text(
        'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectIdx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Subjects',
            backgroundColor: Color.fromARGB(255, 247, 143, 135),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Tutors',
            backgroundColor: Color.fromARGB(255, 129, 197, 242),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_rounded),
            label: 'Subscribe',
            backgroundColor: Color.fromARGB(255, 227, 129, 244),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Color.fromARGB(255, 248, 135, 214),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 252, 189, 53),
          ),
        ],
        currentIndex: _selectIdx,
        selectedItemColor: Colors.black,
        onTap: _onTapped,
      ),
    );
  }
}
