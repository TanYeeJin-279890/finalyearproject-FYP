import 'package:flutter/material.dart';
import '../models/reg.dart';
import 'userlogin.dart';

class MainScreen extends StatefulWidget {
  final Registration reg;
  const MainScreen({Key? key, required this.reg}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double screenHeight, screenWidth, resWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Awesome Courses',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.reg.name.toString()),
              accountEmail: Text(widget.reg.email.toString()),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://blog.cpanel.com/wp-content/uploads/2019/08/user-01.png"),
              ),
            ),
            _createDrawerItem(
              icon: Icons.tv,
              text: 'Products',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              reg: widget.reg,
                            )));
              },
            ),
            _createDrawerItem(
              icon: Icons.local_shipping_outlined,
              text: 'My Cart',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'My Orders',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: 'My Profile',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
  );
}
