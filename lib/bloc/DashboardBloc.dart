import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hording_management/ApiUrls.dart';
import 'package:hording_management/Repository.dart';
import 'package:hording_management/SharedPref.dart';
import 'package:hording_management/model/GetAdsData.dart';
import 'package:hording_management/model/LoginResponse.dart';
import 'package:hording_management/model/Message.dart';

//events
abstract class DashboardEvents extends Equatable {}

class DashboardInitEvent extends DashboardEvents {
  @override
  List<Object?> get props => [];
}

class DashboardActiveAdsEvent extends DashboardEvents {
  final String userId;

  DashboardActiveAdsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class DashboardPausedAdsEvent extends DashboardEvents {
  final String userId;

  DashboardPausedAdsEvent(
    this.userId,
  );

  @override
  List<Object?> get props => [
        userId,
      ];
}

class DashboardInReviewAdsEvent extends DashboardEvents {
  final String userId;

  DashboardInReviewAdsEvent(
    this.userId,
  );

  @override
  List<Object?> get props => [
        userId,
      ];
}

class DashboardExpiredAdsEvent extends DashboardEvents {
  final String userId;

  DashboardExpiredAdsEvent(
    this.userId,
  );

  @override
  List<Object?> get props => [
        userId,
      ];
}

//states
abstract class DashboardStates extends Equatable {}

class DashboardInitState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardInitLoadingState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardActiveAdsLoadingState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardGetPausedLoadingState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardGetInReviewLoadingState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardExpiredAdsLoadingState extends DashboardStates {
  @override
  List<Object?> get props => [];
}

class DashboardActiveAdsSuccessState extends DashboardStates {
  final List<GetAdsData> activeAds;

  DashboardActiveAdsSuccessState(this.activeAds);

  @override
  List<Object?> get props => [activeAds];
}

class DashboardPausedAdsSuccessState extends DashboardStates {
  final List<GetAdsData> pausedAds;

  DashboardPausedAdsSuccessState(this.pausedAds);

  @override
  List<Object?> get props => [pausedAds];
}

class DashboardInReviewAdsSuccessState extends DashboardStates {
  final List<GetAdsData> inReviewAds;

  DashboardInReviewAdsSuccessState(this.inReviewAds);

  @override
  List<Object?> get props => [inReviewAds];
}

class DashboardExpiredAdsSuccessState extends DashboardStates {
  final List<GetAdsData> expiredAds;

  DashboardExpiredAdsSuccessState(this.expiredAds);

  @override
  List<Object?> get props => [expiredAds];
}

class DashboardInitErrorState extends DashboardStates {
  final Message message;

  DashboardInitErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardInitSuccessState extends DashboardStates {
  final LoginResponse? response;

  DashboardInitSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class DashboardBloc extends Bloc<DashboardEvents, DashboardStates> {
  final Repository repository;

  DashboardBloc(this.repository) : super(DashboardInitState()) {
    on<DashboardInitEvent>(initEvent);
    on<DashboardActiveAdsEvent>(getActiveAds);
    on<DashboardPausedAdsEvent>(getPausedAds);
    on<DashboardInReviewAdsEvent>(getInReviewAds);
    on<DashboardExpiredAdsEvent>(getExpiredAds);
  }

  initEvent(DashboardInitEvent event, Emitter<DashboardStates> emitter) async {
    log("DashboardInitLoadingState");
    emitter(DashboardInitLoadingState());
    try {
      var response = await getLoginResponse();
      emitter(DashboardInitSuccessState(response));
    } catch (e) {
      emitter(DashboardInitErrorState(Message(message: "Failed to fetch Login Details")));
    }
  }

  getActiveAds(DashboardActiveAdsEvent event, Emitter<DashboardStates> emitter) async {
    String apiUrl = ApiUrl.fetchUserActiveAds(event.userId.toString());
    emitter(DashboardActiveAdsLoadingState());

    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      var response = await repository.callGetApi(apiUrl);
      List<dynamic> listData = jsonDecode(response.body);
      if (listData.isNotEmpty) {
        List<GetAdsData> list = listData.map((item) => GetAdsData.fromJson(item)).toList();
        emitter(DashboardActiveAdsSuccessState(list));
      } else {
        emitter(DashboardActiveAdsSuccessState(const []));
      }
    } catch (e) {
      emitter(DashboardInitErrorState(Message(message: "Failed to fetch active ads")));
    }
  }

  getPausedAds(DashboardPausedAdsEvent event, Emitter<DashboardStates> emitter) async {
    String apiUrl = ApiUrl.fetchUserPausedAds(event.userId.toString());
    emitter(DashboardGetPausedLoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      var response = await repository.callGetApi(apiUrl);
      List<dynamic> listData = jsonDecode(response.body);
      if (listData.isNotEmpty) {
        List<GetAdsData> list = listData.map((item) => GetAdsData.fromJson(item)).toList();
        emitter(DashboardPausedAdsSuccessState(list));
      } else {
        emitter(DashboardPausedAdsSuccessState(const []));
      }
    } catch (e) {
      emitter(DashboardInitErrorState(Message(message: "Failed to fetch paused ads")));
    }
  }

  getInReviewAds(DashboardInReviewAdsEvent event, Emitter<DashboardStates> emitter) async {
    String apiUrl = ApiUrl.fetchUserInReviewAds(event.userId.toString());
    emitter(DashboardGetInReviewLoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      var response = await repository.callGetApi(apiUrl);
      List<dynamic> listData = jsonDecode(response.body);
      if (listData.isNotEmpty) {
        List<GetAdsData> list = listData.map((item) => GetAdsData.fromJson(item)).toList();
        emitter(DashboardInReviewAdsSuccessState(list));
      } else {
        emitter(DashboardInReviewAdsSuccessState(const []));
      }
    } catch (e) {
      emitter(DashboardInitErrorState(Message(message: "Failed to fetch in-review ads")));
    }
  }

  getExpiredAds(DashboardExpiredAdsEvent event, Emitter<DashboardStates> emitter) async {
    String apiUrl = ApiUrl.fetchUserExpiredAds(event.userId.toString());
    emitter(DashboardExpiredAdsLoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      var response = await repository.callGetApi(apiUrl);
      List<dynamic> listData = jsonDecode(response.body);
      if (listData.isNotEmpty) {
        List<GetAdsData> list = listData.map((item) => GetAdsData.fromJson(item)).toList();
        emitter(DashboardExpiredAdsSuccessState(list));
      } else {
        emitter(DashboardExpiredAdsSuccessState(const []));
      }
    } catch (e) {
      emitter(DashboardInitErrorState(Message(message: "Failed to fetch expired ads")));
    }
  }
}
