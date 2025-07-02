import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hording_management/SharedPref.dart';
import 'package:hording_management/model/UploadResponse.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


Future<Map<String, String>> getHeaders() async {
  final token = (await getLoginResponse())?.token;
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
class Repository {
  Future<Response> calPostApi(dynamic request, String apiUrl) async {
    log(apiUrl);
    log("REQUETS: ${jsonEncode(request)}");
    try {
      return await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(request),
        headers: await getHeaders(),
      );
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  Future<Response> callGetApi(String apiUrl) async {
    log(apiUrl);
    try {
      return await http.get(
        Uri.parse(apiUrl),
        headers: await getHeaders(),
      );
    } catch (e) {
      print('Exception:  $e');
      throw Exception("Something went wrong");
    }
  }

  Future<Response?> fileUploadMultipart(File selectedFile, String userId, String apiUrl) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl), // Change to your server IP/host
    );
    request.fields['user_id'] = userId;
    request.files.add(await http.MultipartFile.fromPath('file', selectedFile.path));
    request.headers.addAll(await getHeaders());
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      print('Uploaded URL: ${responseBody.body}');
      return responseBody;
    } else {
      var responseBody = await http.Response.fromStream(response);
      print('Upload failed with status: ${responseBody.body}');
      return null;
    }
  }
}
