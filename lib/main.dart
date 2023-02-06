// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import './pages/home.dart';
import '../widgets/splash.dart';

void main() {
  runApp(const MyApp());
}

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: 'lib/assets/lottie/splash.json',
      title: const Text(
        "My Weather App",
        style: TextStyle(
          fontFamily: 'RussoOne',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      showLoader: false,
      backgroundColor: const Color.fromRGBO(26, 28, 30, 1),
      loadingText: const Text(
        "powered by accuWeather",
        style: TextStyle(
          fontFamily: 'ChakraPetch',
          fontSize: 15,
          color: Color.fromRGBO(174, 176, 178, 1),
        ),
      ),
      durationInSeconds: 3,
      navigator: '/home',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}
