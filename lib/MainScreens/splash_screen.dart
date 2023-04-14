import 'dart:async';

import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var utils = AppUtils();
  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/backgroundImage.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            scale: 10,
          ),
        ),
      ),
    );
  }

  splashNavigator() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, landingScreenRoute);
    });
  }
}
