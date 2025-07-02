import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/ChangePassword.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SignInApp.dart';
import 'package:hording_management/bloc/AuthorizationBloc.dart';

import 'constants.dart';

class Otp extends StatelessWidget {
  final String email;

  const Otp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Otp(email),
    );
  }
}

class _Otp extends StatefulWidget {
  final String email;

  const _Otp(this.email);

  @override
  State<_Otp> createState() => _OtpState();
}

class _OtpState extends State<_Otp> {
  late AuthorizationBloc _authorizationBloc;
  late Repository repository;
  late TextEditingController otpTextController;

  @override
  void initState() {
    repository = Repository();
    _authorizationBloc = AuthorizationBloc(repository);
    otpTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthorizationBloc>(
      create: (BuildContext context) => _authorizationBloc,
      child: BlocConsumer<AuthorizationBloc, AuthorizationStates>(
        builder: (BuildContext context, AuthorizationStates state) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: const Color(0xFFFCFBFC),
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            forgotPasswordFormImage,
                            height: 200,
                          ),
                          Text(
                            otp,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            otpDescription,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: otpTextController,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(
                              letterSpacing: 20,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              hintText: otp,
                              prefixIcon: const Icon(
                                Icons.access_time_outlined,
                                color: Colors.grey,
                              ),
                              filled: true,
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (otpTextController.text.isEmpty) {
                                  showSnackBar(context, "Please enter valid OTP");
                                  return;
                                }
                                context.read<AuthorizationBloc>().add(AuthorizationVerifyOtpEvent(widget.email, otpTextController.text));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0066FF),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                verifyOtp,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey[300])),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  youRememberYourPassword,
                                  style: GoogleFonts.poppins(color: Colors.grey[600]),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const SignInApp()));
                                  },
                                  child: Text(signIn, style: GoogleFonts.poppins(color: Colors.blue[600], fontWeight: FontWeight.bold))),
                              Expanded(child: Divider(color: Colors.grey[300])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(visible: state is AuthorizationLoadingState, child: const Center(child: CircularProgressIndicator()))
            ],
          );
        },
        listener: (BuildContext context, AuthorizationStates state) {
          if (state is AuthorizationOtpVerifySuccessState) {
            showSnackBar(context, state.message.message.toString());
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => ChangePassword(email: widget.email)));
          }
          if (state is AuthorizationErrorState) {
            showSnackBar(context, state.errorMessage.message.toString());
          }
        },
      ),
    );
  }
}
