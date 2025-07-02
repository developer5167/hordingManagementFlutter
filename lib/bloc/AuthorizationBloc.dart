import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hording_management/ApiUrls.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/model/CreateAccountModel.dart';
import 'package:hording_management/model/LoginResponse.dart';
import 'package:hording_management/model/Message.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvents, AuthorizationStates> {
  final Repository respository;

  AuthorizationBloc(this.respository) : super(AuthorizationInitState()) {
    on<AuthorizationSignInEvent>(signIn);
    on<AuthorizationSignUpEvent>(signUp);
    on<AuthorizationSendOtpEvent>(sendOtp);
    on<AuthorizationVerifyOtpEvent>(verifyOtp);
    on<AuthorizationChangePasswordEvent>(changePassword);
  }

  signIn(AuthorizationSignInEvent event, Emitter<AuthorizationStates> emitter) async {
    String apiUrl = ApiUrl.loginUrl();
    try {
      var response = await respository.calPostApi({"email": event.email, "password": event.password}, apiUrl);
      if (kDebugMode) {
        print('RESPONSE: ${response.body}');
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emitter(AuthorizationLoginSuccessState(LoginResponse.fromJson(map)));
      } else {
        emitter(AuthorizationErrorState(Message.fromJson(map)));
      }
    } catch (e) {
      emitter(AuthorizationErrorState(Message(message: "Something went wrong")));
    }
  }

  signUp(AuthorizationSignUpEvent event, Emitter<AuthorizationStates> emitter) async {
    String apiUrl = ApiUrl.createUser();
    try {
      var response = await respository.calPostApi({"email": event.createAccountModel.email, "password": event.createAccountModel.password, "isActive": true}, apiUrl);
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emitter(AuthorizationSignUpSuccessState(Message.fromJson(map)));
      } else {
        emitter(AuthorizationErrorState(Message.fromJson(map)));
      }
    } catch (e) {
      emitter(AuthorizationErrorState(Message(message: "Something went wrong")));
    }
  }

  changePassword(AuthorizationChangePasswordEvent event, Emitter<AuthorizationStates> emitter) async {
    String apiUrl = ApiUrl.changeLoginPassword();
    try {
      var response = await respository.calPostApi({"email": event.email, "password": event.password}, apiUrl);
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emitter(AuthorizationChangePasswordSuccessState(Message.fromJson(map)));
      } else {
        emitter(AuthorizationErrorState(Message.fromJson(map)));
      }
    } catch (e) {
      emitter(AuthorizationErrorState(Message(message: "Something went wrong")));
    }
  }

  verifyOtp(AuthorizationVerifyOtpEvent event, Emitter<AuthorizationStates> emitter) async {
    emitter(AuthorizationLoadingState());
    String apiUrl = ApiUrl.verifyOtp();
    try {
      var response = await respository.calPostApi({"email": event.email, "otp": event.otp}, apiUrl);
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emitter(AuthorizationOtpVerifySuccessState(Message.fromJson(map)));
      } else {
        emitter(AuthorizationErrorState(Message.fromJson(map)));
      }
    } catch (e) {
      emitter(AuthorizationErrorState(Message(message: "Something went wrong")));
    }
  }

  sendOtp(AuthorizationSendOtpEvent event, Emitter<AuthorizationStates> emitter) async {
    emitter(AuthorizationLoadingState());
    String apiUrl = ApiUrl.sendOtp();
    try {
      var response = await respository.calPostApi({"email": event.email}, apiUrl);
      Map<String, dynamic> map = jsonDecode(response.body);
      emitter(AuthorizationOtpSendSuccessState(Message.fromJson(map)));
    } catch (e) {
      emitter(AuthorizationErrorState(Message(message: "Something went wrong")));
    }
  }
}

abstract class AuthorizationEvents extends Equatable {}

class AuthorizationSignUpEvent extends AuthorizationEvents {
  final CreateAccountModel createAccountModel;

  AuthorizationSignUpEvent(this.createAccountModel);

  @override
  List<Object?> get props => [createAccountModel];
}

class AuthorizationChangePasswordEvent extends AuthorizationEvents {
  final String email;
  final String password;

  AuthorizationChangePasswordEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthorizationSignInEvent extends AuthorizationEvents {
  final String email;
  final String password;

  AuthorizationSignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthorizationVerifyOtpEvent extends AuthorizationEvents {
  final String email;
  final String otp;

  AuthorizationVerifyOtpEvent(this.email, this.otp);

  @override
  List<Object?> get props => [email, otp];
}

class AuthorizationSendOtpEvent extends AuthorizationEvents {
  final String email;

  AuthorizationSendOtpEvent(this.email);

  @override
  List<Object?> get props => [email];
}

abstract class AuthorizationStates extends Equatable {}

class AuthorizationInitState extends AuthorizationStates {
  @override
  List<Object?> get props => [];
}

class AuthorizationLoadingState extends AuthorizationStates {
  @override
  List<Object?> get props => [];
}

class AuthorizationErrorState extends AuthorizationStates {
  final Message errorMessage;

  AuthorizationErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthorizationOtpSendSuccessState extends AuthorizationStates {
  final Message message;

  AuthorizationOtpSendSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthorizationOtpVerifySuccessState extends AuthorizationStates {
  final Message message;

  AuthorizationOtpVerifySuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthorizationLoginSuccessState extends AuthorizationStates {
  final LoginResponse response;

  AuthorizationLoginSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthorizationSignUpSuccessState extends AuthorizationStates {
  final Message message;

  AuthorizationSignUpSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthorizationChangePasswordSuccessState extends AuthorizationStates {
  final Message errorMessage;

  AuthorizationChangePasswordSuccessState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
