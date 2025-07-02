import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/AdDashboardApp.dart';
import 'package:hording_management/SharedPref.dart';
import 'package:hording_management/SignInApp.dart';
import 'package:hording_management/model/LoginResponse.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        checkLoginStatus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/noBg.png",
              width: 150,
            ),
            Text(
              "Kapil Ads Manager",
              style: GoogleFonts.poppins(),
            )
          ],
        ),
      ),
    );
  }

  void checkLoginStatus() async {
    LoginResponse? response = await getLoginResponse();
    if (kDebugMode) {
      print('RESPONSE :   ${response?.toJson()}  ${response?.token}');
    }
    if (!mounted) return;
    if (response?.token == null || response?.token == "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInApp()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }
}
