import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String enterValidUserName = "Enter valid user name & password to continue";
const String useProperInformation = "Use proper information to continue";
const String changePasswordDescription = "Make sure to remember your password";
const String forgotPasswordDescription = "Don't worry it happens. Please enter the address associated with your account";
const String otpDescription = "Please enter the otp sent to registered email";
const String userName = 'User name';
const String fullName = 'Full Name';
const String emailAddress = 'Email address';
const String forgotPassword = 'Forget password';
const String otp = 'OTP';
const String bySigningNote = 'By signing up you are agreed to our';
const String termsAndConditions = 'Terms & Conditions';
const String privacyPolicy = 'Privacy Policy';
const String login = 'Login';
const String createAccount = 'Create Account';
const String sendOtp = 'Send OTP';
const String verifyOtp = 'Verify OTP';
const String orContinueWith = 'Or Continue with';
const String alreadyHaveAnAccount = 'Already have an Account?';
const String youRememberYourPassword = 'You remember your password?';
const String google = 'Google';
const String password = 'Password';
const String confirmPassword = 'Confirm Password';
const String facebook = 'Facebook';
const String signUp = 'Sign Up';
const String submit = 'Submit';
const String signIn = 'Sign In';
const String changePassword = 'Change Password';
const String haventAnyAccount = "Haven't any account? ";
const String googleLogo = 'images/google_logo.png';
const String loginFormImage = 'images/signin.png';
const String signUpFormImage = 'images/signup.png';
const String forgotPasswordFormImage = 'images/forgotpassword.png';
const String apiUrl = 'API URL:';
const String loginResponse = 'login_response';

const blueColor = Color(0xFF0D62D9);
const yellowColor = Color(0xFFFCCD32);



showSnackBar(BuildContext context, String content, {int duration = 4}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        content,
        style: GoogleFonts.poppins(
          fontSize: 12,
        ),
      ),
      duration: Duration(seconds: duration),
    ));
}
