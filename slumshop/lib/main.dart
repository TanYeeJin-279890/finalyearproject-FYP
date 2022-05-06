//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:slumshop/views/mainscrn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlumShop',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MySplashScreen(title: 'SlumShop Admin'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/1.png'), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
