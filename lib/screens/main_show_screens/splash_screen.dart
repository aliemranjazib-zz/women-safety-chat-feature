import 'dart:async';

import 'package:flutter/material.dart';

import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => LandingScren()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Image.asset("images/doc_logo.jpg"),
          ),
          Text(
            "Doctor Patient App",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
