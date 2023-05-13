import 'package:flutter/material.dart';
import '../fix.dart';
import '../models/reg.dart';
import 'login.dart';
import 'register.dart';
import 'start.dart';

class MainScreen extends StatefulWidget {
  final Registration reg;
  const MainScreen({Key? key, required this.reg}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const StartPage(),
      const RegisterPage(),
      const LoginPage(),
      //HistoryPage(),
      //ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        iconSize: 28,
        backgroundColor: background,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: selectbtn,
        onTap: _onTapped,
      ),
    );
  }
}
