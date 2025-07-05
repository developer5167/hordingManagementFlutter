import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hording_management/ApiUrls.dart';
import 'package:hording_management/Repository.dart';

class AdminSettingsBloc extends Bloc<AdminSettingsEvents, AdminSettingsStates> {
  final Repository respository;

  AdminSettingsBloc(this.respository) :super(AdminSettingsInitState()) {
    on<SettingsTurnOfClientAdsEvent>(turnOfClientAds);
    on<SettingsTurnOfAllAdsEvent>(turnOfAllAds);
    on<GetAllSettingsEvent>(getAllSettingsEvent);
  }

  void turnOfClientAds(SettingsTurnOfClientAdsEvent event, Emitter<AdminSettingsStates> emitter) async {
    emitter(SettingsTurnOfClientAdsLoadingState());
    String apiUrl = ApiUrl.turnOfClientAds(event.device_id,event.isEnabled);
    try {
      var response = await respository.callGetApi(apiUrl);
      emitter(SettingsTurnOfClientAdsSuccessState(response.body));
    } catch (e) {
      emitter(SettingsTurnOfClientAdsErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }


  void turnOfAllAds(SettingsTurnOfAllAdsEvent event, Emitter<AdminSettingsStates> emitter) async {
    emitter(SettingsTurnOfClientAdsLoadingState());
    String apiUrl = ApiUrl.turnOffAllAds(event.device_id,event.isEnabled);
    try {
      var response = await respository.callGetApi(apiUrl);
      emitter(SettingsTurnOfAllAdsSuccessState(response.body));
    } catch (e) {
      emitter(SettingsTurnOfAllAdsErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }
  void getAllSettingsEvent(GetAllSettingsEvent event, Emitter<AdminSettingsStates> emitter) async {
    emitter(SettingsTurnOfClientAdsLoadingState());
    String apiUrl = ApiUrl.getAllSettingsEvent(event.device_id);
    try {
      var response = await respository.callGetApi(apiUrl);
      Map<String,dynamic> map = jsonDecode(response.body);
      emitter(GetAllSettingsSuccessState(map["deviceId"],map["showClientAds"],map["pauseAllAds"]));
    } catch (e) {
      emitter(SettingsTurnOfClientAdsErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }

}


abstract class AdminSettingsEvents extends Equatable {}

class SettingsTurnOfClientAdsEvent extends AdminSettingsEvents {
  final String device_id;
  final bool isEnabled;
  SettingsTurnOfClientAdsEvent(this.device_id,this.isEnabled);
  @override
  List<Object?> get props => [device_id,isEnabled];

}
class SettingsTurnOfAllAdsEvent extends AdminSettingsEvents {
  final String device_id;
  final bool isEnabled;
  SettingsTurnOfAllAdsEvent(this.device_id,this.isEnabled);
  @override
  List<Object?> get props => [device_id,isEnabled];

}
class GetAllSettingsEvent extends AdminSettingsEvents{
  final String device_id;
  GetAllSettingsEvent(this.device_id);

  @override
  List<Object?> get props => [device_id];

}
class GetAllSettingsLoadingState extends AdminSettingsStates{

  @override
  List<Object?> get props => [];

}


abstract class AdminSettingsStates extends Equatable {}

class AdminSettingsInitState extends AdminSettingsStates {
  @override
  List<Object?> get props => [];

}

class SettingsTurnOfClientAdsLoadingState extends AdminSettingsStates {
  @override
  List<Object?> get props => [];

}class SettingsTurnOfAllAdsLoadingState extends AdminSettingsStates {
  @override
  List<Object?> get props => [];

}
class GetAllSettingsSuccessState extends AdminSettingsStates{
  final String device_id;
  final bool showClientAds;
  final bool pauseAllAds;

  GetAllSettingsSuccessState(this.device_id, this.showClientAds,this.pauseAllAds);

  @override
  List<Object?> get props => [device_id,showClientAds,pauseAllAds];

}
class SettingsTurnOfClientAdsErrorState extends AdminSettingsStates {
  final String message;

  SettingsTurnOfClientAdsErrorState(this.message);

  @override
  List<Object?> get props => [message];

}
class SettingsAllAdsErrorState extends AdminSettingsStates {
  final String message;

  SettingsAllAdsErrorState(this.message);

  @override
  List<Object?> get props => [message];

}

class SettingsTurnOfClientAdsSuccessState extends AdminSettingsStates {
  final String isEnabled;

  SettingsTurnOfClientAdsSuccessState(this.isEnabled);
  @override
  List<Object?> get props => [isEnabled];

}
class SettingsTurnOfAllAdsSuccessState extends AdminSettingsStates {
  final String isEnabled;

  SettingsTurnOfAllAdsSuccessState(this.isEnabled);
  @override
  List<Object?> get props => [isEnabled];

}
class SettingsTurnOfAllAdsErrorState extends AdminSettingsStates {
  final String isEnabled;

  SettingsTurnOfAllAdsErrorState(this.isEnabled);
  @override
  List<Object?> get props => [isEnabled];

}