import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/bloc/AdminSettingsBloc.dart';
import 'package:hording_management/bloc/UploadAdScreenBloc.dart';
import 'package:hording_management/model/DeviceIdModel.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  _AdminSettingsScreenState createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final deviceIdController = TextEditingController();
  bool switchState = false;
  late UploadAdsScreenBloc uploadAdsScreenBloc;
  late AdminSettingsBloc adminSettingsBloc;
  List<DeviceIdModel> deviceIds = [];

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
                    adminSettingsBloc.add(GetAllSettingsEvent(deviceIdController.text));
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
    adminSettingsBloc = AdminSettingsBloc(Repository());
    uploadAdsScreenBloc.add(GetDeviceIdsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15)),
        ),
        centerTitle: false,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UploadAdsScreenBloc>(create: (_) => uploadAdsScreenBloc),
          BlocProvider<AdminSettingsBloc>(create: (_) => adminSettingsBloc),
        ],
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Device",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    BlocBuilder<UploadAdsScreenBloc, UploadAdsStates>(
                      builder: (BuildContext context, UploadAdsStates state) {
                        if (state is UploadAdsSuccessState) {
                          deviceIds = state.list;
                        }
                        return GestureDetector(
                          onTap: _openDevicePicker,
                          child: AbsorbPointer(
                            child: TextField(
                              controller: deviceIdController,
                              decoration: _inputDecoration(hint: "Device ID", prefixIcon: Icons.devices),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AdminSettingsBloc, AdminSettingsStates>(
                      builder: (BuildContext context, AdminSettingsStates state) {
                        print('STATE  $state');
                        if (state is GetAllSettingsSuccessState) {
                          switchState = state.showClientAds;
                        }
                        if (state is SettingsTurnOfClientAdsSuccessState) {
                          switchState = state.isEnabled == "true" ? true : false;
                        }
                        if (kDebugMode) {
                          print('STATUS: $switchState');
                        }
                        return Row(
                          children: [
                            Text(
                              "Turn off Client Ads",
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                            state is SettingsTurnOfClientAdsLoadingState
                                ? const CircularProgressIndicator()
                                : Switch(
                                    value: switchState,
                                    onChanged: (data) {
                                      context.read<AdminSettingsBloc>().add(SettingsTurnOfClientAdsEvent(deviceIdController.text, data));
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<UploadAdsScreenBloc, UploadAdsStates>(
              builder: (context, counterState) {
                return BlocBuilder<AdminSettingsBloc, AdminSettingsStates>(
                  builder: (context, themeState) {
                    final isLoading = counterState is UploadAdsLoadingState || themeState is GetAllSettingsLoadingState;
                    return isLoading
                        ? Center(
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: const CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
