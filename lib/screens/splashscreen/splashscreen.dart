import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/homepage/view/homepage_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomePage();
  }

  navigateToHomePage() async {
    var durationSplash = const Duration(seconds: 5);

    return Timer(durationSplash, () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (x) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/kitchenware.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
