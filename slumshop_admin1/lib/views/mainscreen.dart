import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text("My DashBoard")
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.admin.name)),
            )
          ]
        ),
      )
    );
  }
}
