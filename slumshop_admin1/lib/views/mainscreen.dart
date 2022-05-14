import 'package:flutter/material.dart';

import '../models/admin.dart';

class MainScreen extends StatefulWidget {
  final Admin admin;
  const MainScreen({
    Key? key,
    required this.admin,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My DashBoard")),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.admin.name.toString()),
            accountEmail: Text(widget.admin.email.toString()),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage("assets/images/profile.png"),
            ),
          ),
          _createDrawerItem(
            icon: Icons.tv,
            text: 'My Dashboard',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(
                            admin: widget.admin,
                          )));
            },
          ),
          _createDrawerItem(
            icon: Icons.list_alt,
            text: 'My Products',
            onTap: () {
              Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (content) => ProductScreen(
              //                 admin: widget.admin,
              //               )));
            },
          ),
          _createDrawerItem(
            icon: Icons.local_shipping_outlined,
            text: 'My Orders',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.local_shipping_outlined,
            text: 'My Orders',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.local_shipping_outlined,
            text: 'My Orders',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.local_shipping_outlined,
            text: 'My Orders',
            onTap: () {},
          ),
        ]),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
        title: Row(children: <Widget>[
      Icon(icon),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(text),
      )
    ]));
  }
}
