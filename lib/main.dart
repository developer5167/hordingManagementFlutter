import 'package:flutter/material.dart';
import 'package:hording_management/SignInApp.dart';

import 'SplashScreen.dart';

void main() {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Kapi Ads Manager',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}




