import 'dart:async';
import 'package:flutter/material.dart';
import 'currency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScrn(),
    );
  }
}

class SplashScrn extends StatefulWidget {
  const SplashScrn({Key? key}) : super(key: key);

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const CurrencyCalc())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              height: 816,
              width: 412,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bitcoin.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter)),
              child: const Text("Welcome to Currrency Calculator",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontStyle: FontStyle.italic)),
              alignment: Alignment.center)),
    );
  }
}
