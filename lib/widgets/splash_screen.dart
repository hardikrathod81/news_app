import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/widgets/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'NEWS',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 105),
            ),
          ),
          SizedBox(
            height: height * 0.12,
          ),
          const Center(
            child: Text(
              'Go To The  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35),
            ),
          ),
          SizedBox(
            height: height * 0.0,
          ),
          const Text(
            'TOP HEADLINES',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
