import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SharedPref.dart';
import 'package:hording_management/bloc/UploadAdScreenBloc.dart';
import 'package:hording_management/constants.dart';
import 'package:hording_management/model/DeviceIdModel.dart';
import 'package:hording_management/model/LoginResponse.dart';
import 'package:hording_management/model/PostAdData.dart';
import 'package:intl/intl.dart';

import 'ApiUrls.dart';

class AdminUploadScreen extends StatefulWidget {
  const AdminUploadScreen({super.key});

  @override
  _AdminUploadScreenState createState() => _AdminUploadScreenState();
}

class _AdminUploadScreenState extends State<AdminUploadScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deviceIdController = TextEditingController();
  final selectedFileController = TextEditingController();
  late File file;

  late UploadAdsScreenBloc uploadAdsScreenBloc;
  List<DeviceIdModel> deviceIds = [];

  DateTime? startDate;
  DateTime? endDate;


  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["mp4","jpg","png","jpeg"]
    );
    if (result != null) {
      selectedFileController.text = result.files.single.name;
      file = File(result.files.single.path.toString());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File selected: ${result.files.single.name}")));
    }
  }

  InputDecoration _inputDecoration({required String hint, IconData? prefixIcon}) {
    return InputDecoration(
      hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      hintText: hint,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
    );
  }

  void _openDevicePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: deviceIds.length,
            itemBuilder: (_, index) {
              final device = deviceIds[index];
              return Card(
                child: ListTile(
                  title: Text(device.deviceId.toString()),
                  onTap: () {
                    deviceIdController.text = device.deviceId.toString();
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    uploadAdsScreenBloc = UploadAdsScreenBloc(Repository());
    uploadAdsScreenBloc.add(GetDeviceIdsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Ad",
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15)),
        ),
        centerTitle: false,
      ),
      body: BlocProvider<UploadAdsScreenBloc>(
          create: (BuildContext context) => uploadAdsScreenBloc,
          child: BlocConsumer<UploadAdsScreenBloc, UploadAdsStates>(
            builder: (BuildContext context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: _inputDecoration(hint: "Title", prefixIcon: Icons.title),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: descriptionController,
                            decoration: _inputDecoration(hint: "Description", prefixIcon: Icons.description),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openDevicePicker,
                            child: AbsorbPointer(
                              child: TextField(
                                controller: deviceIdController,
                                decoration: _inputDecoration(hint: "Device ID", prefixIcon: Icons.devices),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: deviceIds.isNotEmpty ? _pickFile : null,
                            child: TextField(
                              enabled: false,
                              controller: selectedFileController,
                              decoration: _inputDecoration(hint: "Upload Image/Video", prefixIcon: Icons.description),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: deviceIds.isNotEmpty
                                  ? () {
                                      if (titleController.text.isEmpty) {
                                        showSnackBar(context, "Please enter Title");
                                        return;
                                      }
                                      if (descriptionController.text.isEmpty) {
                                        showSnackBar(context, "Please enter Description");
                                        return;
                                      }
                                      if (deviceIdController.text.isEmpty) {
                                        showSnackBar(context, "Please select Device Id");
                                        return;
                                      }
                                      if (selectedFileController.text.isEmpty) {
                                        showSnackBar(context, "Please select file");
                                        return;
                                      }
                                      submitForm();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: deviceIds.isNotEmpty ? const Color(0xFF0066FF) : Colors.grey,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                submit,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state is UploadAdsLoadingState,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                ],
              );
            },
            listener: (BuildContext context, Object? state) {
              if (state is UploadAdsErrorState) {
                showSnackBar(context, state.message.message.toString());
              }
              if (state is UploadAdsSuccessState) {
                deviceIds = state.list;
                if (deviceIds.isEmpty) {
                  showSnackBar(context, "Failed to fetch device Id's");
                }
              }
              if (state is FilesUploadSuccessState) {
                saveData(state.uploadResponse, state.fileName);
              }
              if (state is FilesUploadFailureState) {
                showSnackBar(context, state.message.message.toString());
              }
              if (state is UploadAdsSaveAdSuccessState) {
                deviceIdController.text = "";
                descriptionController.text = "";
                titleController.text = "";
                selectedFileController.text = "";
                showSnackBar(context, state.message.message.toString());
              }
            },
          )),
    );
  }

  void submitForm() async {
    LoginResponse? loginResponse = await getLoginResponse();
   var userid = loginResponse?.userId = 0;
    uploadAdsScreenBloc.add(FilesUploadInitEvent(file,userid));
  }

  void saveData(String uploadResponse, String fileName) async {
    PostAdData postAdData = PostAdData();
    postAdData.deviceId = deviceIdController.text;
    postAdData.description = descriptionController.text;
    postAdData.title = titleController.text;
    postAdData.adData = uploadResponse;
    postAdData.isactive = true;
    postAdData.fileName = fileName;
    postAdData.memeType = (uploadResponse.contains(".jpg") || uploadResponse.contains(".png") || uploadResponse.contains(".jpeg")) ? "IMAGE" : "VIDEO";
    log("request: ${jsonEncode(postAdData.toJson())}");
    String apiUrl = ApiUrl.saveCompanyAdData();
    uploadAdsScreenBloc.add(SaveAdDataEvent(postAdData,apiUrl),);
  }
}
