import 'dart:convert';

import 'package:hording_management/constants.dart';
import 'package:hording_management/model/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginResponse(LoginResponse response) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(response.toJson());
  await prefs.setString(loginResponse, jsonString);
}

Future<LoginResponse?> getLoginResponse() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(loginResponse);
  if (jsonString == null) return null;
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  return LoginResponse.fromJson(jsonMap);
}

Future<void> clearLoginResponse() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(loginResponse);
}
