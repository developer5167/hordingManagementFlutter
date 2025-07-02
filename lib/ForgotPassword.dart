import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/Otp.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SignInApp.dart';
import 'package:hording_management/bloc/AuthorizationBloc.dart';

import 'constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ForgotPasswordPage(),
    );
  }
}

class _ForgotPasswordPage extends StatefulWidget {
  const _ForgotPasswordPage();

  @override
  State<_ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<_ForgotPasswordPage> {
  late AuthorizationBloc _authorizationBloc;
  late Repository _repository;
  late TextEditingController emailTextEditor;

  @override
  void initState() {
    _repository = Repository();
    emailTextEditor = TextEditingController();
    _authorizationBloc = AuthorizationBloc(_repository);

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
                            forgotPassword,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            forgotPasswordDescription,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: emailTextEditor,
                            style: GoogleFonts.poppins(
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
                              hintText: emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
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
                                if (emailTextEditor.text.isEmpty) {
                                  showSnackBar(context, "Please enter valid email");
                                  return;
                                }
                                context.read<AuthorizationBloc>().add(AuthorizationSendOtpEvent(emailTextEditor.text));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0066FF),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                sendOtp,
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
          if (state is AuthorizationOtpSendSuccessState) {
            showSnackBar(context, state.message.message.toString());
            print('MESSAGE: ${state.message.message}');
            Navigator.push(context, MaterialPageRoute(builder: (builder) =>  Otp(email: state.message.email.toString(),)));
          }
          if (state is AuthorizationErrorState) {
            showSnackBar(context, state.errorMessage.message.toString());
          }
        },
      ),
    );
  }
}
