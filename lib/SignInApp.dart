import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/AdDashboardApp.dart';
import 'package:hording_management/ForgotPassword.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SharedPref.dart';
import 'package:hording_management/SignUpApp.dart';
import 'package:hording_management/bloc/AuthorizationBloc.dart';
import 'constants.dart';

class SignInApp extends StatelessWidget {
  const SignInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _SignInPage(),
    );
  }
}

class _SignInPage extends StatefulWidget {
  const _SignInPage();

  @override
  State<_SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<_SignInPage> {
  late AuthorizationBloc _authorizationBloc;
  late Repository repository;
  late TextEditingController emailTextEditor;
  late TextEditingController passwordTextEditor;

  @override
  void initState() {
    repository = Repository();
    emailTextEditor = TextEditingController();
    passwordTextEditor = TextEditingController();
    _authorizationBloc = AuthorizationBloc(repository);
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditor.clear();
    passwordTextEditor.clear();
    _authorizationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthorizationBloc>(
      create: (BuildContext context) => _authorizationBloc,
      child: BlocConsumer<AuthorizationBloc, AuthorizationStates>(
        builder: (BuildContext context, AuthorizationStates state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            loginFormImage,
                            height: 200,
                          ),
                          Text(
                            signIn,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            enterValidUserName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            textInputAction: TextInputAction.send,
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
                              hintText: userName,
                              prefixIcon: const Icon(
                                Icons.person_outline,
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
                          TextField(
                            controller: passwordTextEditor,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              hintText: password,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                              ),
                              suffixIcon: const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (builder) => const ForgotPassword()));
                              },
                              child: Text(
                                forgotPassword,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (emailTextEditor.text.isEmpty || passwordTextEditor.text.isEmpty) {
                                  showSnackBar(context, "Please enter valid details");
                                  return;
                                }
                                context.read<AuthorizationBloc>().add(AuthorizationSignInEvent(emailTextEditor.text, passwordTextEditor.text));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0066FF),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                login,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     Expanded(child: Divider(color: Colors.grey[300])),
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //       child: Text(
                          //         orContinueWith,
                          //         style: GoogleFonts.poppins(color: Colors.grey[600]),
                          //       ),
                          //     ),
                          //     Expanded(child: Divider(color: Colors.grey[300])),
                          //   ],
                          // ),
                          // const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     ElevatedButton.icon(
                          //       onPressed: () {},
                          //       icon: Image.asset(googleLogo, height: 24),
                          //       label: Text(
                          //         google,
                          //         style: GoogleFonts.poppins(color: Colors.black),
                          //       ),
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.white,
                          //         elevation: 1,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           side: BorderSide(color: Colors.grey.shade300),
                          //         ),
                          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          //       ),
                          //     ),
                          //     ElevatedButton.icon(
                          //       onPressed: () {},
                          //       icon: const Icon(Icons.facebook, color: Colors.blue),
                          //       label: Text(
                          //         facebook,
                          //         style: GoogleFonts.poppins(color: Colors.black),
                          //       ),
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.white,
                          //         elevation: 1,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           side: BorderSide(color: Colors.grey.shade300),
                          //         ),
                          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                haventAnyAccount,
                                style: GoogleFonts.poppins(color: Colors.grey[600]),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const SignUpApp()));
                                  },
                                  child: Text(signUp, style: GoogleFonts.poppins(color: Colors.blue[600], fontWeight: FontWeight.bold))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state is AuthorizationLoadingState,
                    child: const CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, AuthorizationStates state) {
          if (state is AuthorizationErrorState) {
            showSnackBar(context, state.errorMessage.message.toString());
          }
          if (state is AuthorizationLoginSuccessState) {
            saveLoginResponse(state.response);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const AdDashboardApp()));
          }
        },
      ),
    );
  }
}
