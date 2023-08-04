import 'dart:async';

import 'package:flutter/material.dart';

import 'home-screen.dart';

class WelcomToWeatherScreen extends StatefulWidget {
  const WelcomToWeatherScreen({Key? key}) : super(key: key);

  @override
  State<WelcomToWeatherScreen> createState() => _WelcomToWeatherScreenState();
}

class _WelcomToWeatherScreenState extends State<WelcomToWeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('images/weather.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
