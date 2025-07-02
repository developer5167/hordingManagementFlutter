import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hording_management/ApiUrls.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/model/DeviceIdModel.dart';
import 'package:hording_management/model/LoginResponse.dart';
import 'package:hording_management/model/Message.dart';
import 'package:hording_management/model/PostAdData.dart';
import 'package:http/http.dart';

import '../SharedPref.dart';

class UploadAdsScreenBloc extends Bloc<UploadAdsEvents, UploadAdsStates> {
  final Repository respository;

  UploadAdsScreenBloc(this.respository) : super(UploadAdsInitState()) {
    on<GetDeviceIdsEvent>(getDeviceId);
    on<FilesUploadInitEvent>(uploadFiles);
    on<SaveAdDataEvent>(saveData);
  }

  getDeviceId(GetDeviceIdsEvent events, Emitter<UploadAdsStates> emitter) async {
    String apiUrl = ApiUrl.getDeviceIds();
    emitter(UploadAdsLoadingState());
    try {
      var response = await respository.callGetApi(apiUrl);
      print('RESPONSE: ${response.body}');
      List<dynamic> deviceModel = jsonDecode(response.body);
      List<DeviceIdModel> deviceModelList = deviceModel.map((item) => DeviceIdModel.fromJson(item)).toList();
      emitter(UploadAdsSuccessState(deviceModelList));
    } catch (e) {
      print('exception $e');
      emitter(UploadAdsErrorState(Message(message: "Something went wrong")));
    }
  }

  uploadFiles(FilesUploadInitEvent event, Emitter<UploadAdsStates> emitter) async {
    String apiUrl = ApiUrl.upload();
    emitter(UploadAdsLoadingState());
    LoginResponse? loginResponse = await getLoginResponse();
    try {
      Response? uploadResponse = await respository.fileUploadMultipart(event.file, loginResponse!.userId.toString(), apiUrl);
      if(uploadResponse!=null) {
        Map<String, dynamic> map = jsonDecode(uploadResponse.body);
        log('RESPONSE : ${map["url"]}');
        emitter(FilesUploadSuccessState(map["url"],map["filename"]));
      }else{
        emitter(FilesUploadFailureState(Message(message: "Image upload response failed")));
      }
    } catch (e) {
      print('EXCEPTION: $e');
      emitter(FilesUploadFailureState(Message(message: e.toString().replaceAll("Exception :", ""))));
    }
  }

  saveData(SaveAdDataEvent event, Emitter<UploadAdsStates> emitter) async {
    String apiUrl = ApiUrl.saveAdData();
    emitter(UploadAdsLoadingState());
    try {
      var response = await respository.calPostApi(event.postAdData, apiUrl);
      if (kDebugMode) {
        print('RESPONSE: ${response.body}');
      }
      emitter(UploadAdsSaveAdSuccessState(Message.fromJson(jsonDecode(response.body))));
    } catch (e) {
      print('exception $e');
      emitter(UploadAdsErrorState(Message(message: "Something went wrong")));
    }
  }
}

abstract class UploadAdsEvents extends Equatable {}

class GetDeviceIdsEvent extends UploadAdsEvents {
  @override
  List<Object?> get props => [];
}

class SaveAdDataEvent extends UploadAdsEvents {
  final PostAdData postAdData;

  SaveAdDataEvent(this.postAdData);

  @override
  List<Object?> get props => [postAdData];
}

class FilesUploadInitEvent extends UploadAdsEvents {
  final File file;

  FilesUploadInitEvent(this.file);

  @override
  List<Object?> get props => [file];
}

abstract class UploadAdsStates extends Equatable {}

class UploadAdsInitState extends UploadAdsStates {
  @override
  List<Object?> get props => [];
}

class FilesUploadSuccessState extends UploadAdsStates {
  final String uploadResponse;
  final String fileName;

  FilesUploadSuccessState(this.uploadResponse,this.fileName);

  @override
  List<Object?> get props => [uploadResponse,fileName];
}

class FilesUploadFailureState extends UploadAdsStates {
  final Message message;

  FilesUploadFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadAdsLoadingState extends UploadAdsStates {
  @override
  List<Object?> get props => [];
}
class UploadAdsSaveAdSuccessState extends UploadAdsStates {
  final Message message;

  UploadAdsSaveAdSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class UploadAdsSuccessState extends UploadAdsStates {
  final List<DeviceIdModel> list;

  UploadAdsSuccessState(this.list);

  @override
  List<Object?> get props => [list];
}

class UploadAdsErrorState extends UploadAdsStates {
  final Message message;

  UploadAdsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
