import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SignInApp.dart';
import 'package:hording_management/bloc/AuthorizationBloc.dart';
import 'package:hording_management/model/CreateAccountModel.dart';

import 'constants.dart';

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _SignUpPage(),
    );
  }
}

class _SignUpPage extends StatefulWidget {
  const _SignUpPage();

  @override
  State<_SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<_SignUpPage> {
  late AuthorizationBloc _authorizationBloc;
  late Repository repository;
  late TextEditingController emailTextEditor;
  late TextEditingController passwordTextEditor;
  late TextEditingController cPasswordTextEditor;

  @override
  void initState() {
    repository = Repository();
    emailTextEditor = TextEditingController();
    passwordTextEditor = TextEditingController();
    cPasswordTextEditor = TextEditingController();
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
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: const Color(0xFFF7F6F7),
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            signUpFormImage,
                            height: 200,
                          ),
                          Text(
                            signUp,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            useProperInformation,
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
                          TextField(
                            controller: passwordTextEditor,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              hintText: password,
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
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
                          const SizedBox(height: 20),
                          TextField(
                            controller: cPasswordTextEditor,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                              ),
                              hintText: confirmPassword,
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
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
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  bySigningNote,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      termsAndConditions,
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      " and ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      privacyPolicy,
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (emailTextEditor.text.isEmpty) {
                                  showSnackBar(context, "Please enter email address");
                                  return;
                                }
                                if (passwordTextEditor.text.isEmpty) {
                                  showSnackBar(context, "Please enter valid password");
                                  return;
                                }
                                if (cPasswordTextEditor.text.isEmpty) {
                                  showSnackBar(context, "Please enter valid confirm password");
                                  return;
                                }
                                if (cPasswordTextEditor.text != passwordTextEditor.text) {
                                  showSnackBar(context, "Passwords mismatch");
                                  return;
                                }
                                var createAccountModel = CreateAccountModel();
                                createAccountModel.email = emailTextEditor.text;
                                createAccountModel.password = passwordTextEditor.text;
                                context.read<AuthorizationBloc>().add(AuthorizationSignUpEvent(createAccountModel));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0066FF),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                createAccount,
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
                                  alreadyHaveAnAccount,
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
              Visibility(
                visible: state is AuthorizationLoadingState,
                child: const CircularProgressIndicator(),
              )
            ],
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is AuthorizationErrorState) {
            showSnackBar(context, state.errorMessage.message.toString());
          }
          if (state is AuthorizationSignUpSuccessState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const SignInApp()));
          }
        },
      ),
    );
  }
}
