import 'package:flutter/material.dart';
import '../fix.dart';
import 'login.dart';
import 'register.dart';
import 'start.dart';

class MainScreenWithoutLogin extends StatefulWidget {
  const MainScreenWithoutLogin({Key? key}) : super(key: key);

  @override
  State<MainScreenWithoutLogin> createState() => _MainScreenWithoutLoginState();
}

class _MainScreenWithoutLoginState extends State<MainScreenWithoutLogin> {
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
