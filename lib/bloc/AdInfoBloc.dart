import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hording_management/ApiUrls.dart';
import 'package:hording_management/Repository.dart';

abstract class AdInfoEvents extends Equatable {}

abstract class AdInfoStates extends Equatable {}

class AdInfoGetStaticsEvent extends AdInfoEvents {
  final String adId;

  AdInfoGetStaticsEvent(this.adId);
  @override
  List<Object?> get props => [adId];
}

class AdInfoInitState extends AdInfoStates {
  @override
  List<Object?> get props => [];
}

class AdInfoLoadingState extends AdInfoStates {
  @override
  List<Object?> get props => [];
}

class AdInfoErrorState extends AdInfoStates {
  @override
  List<Object?> get props => [];
}

class AdInfoSuccessState extends AdInfoStates {
  @override
  List<Object?> get props => [];
}

class AdInfoBloc extends Bloc<AdInfoEvents, AdInfoStates> {
  final Repository repository;

  AdInfoBloc(this.repository) : super(AdInfoInitState()) {
    on<AdInfoGetStaticsEvent>(getStatics);
  }

  getStatics(AdInfoGetStaticsEvent event, Emitter<AdInfoStates> emitter) async{
    String apiUrl = ApiUrl.getStatics(event.adId);
    emitter(AdInfoLoadingState());
    try{
      var response = await repository.callGetApi(apiUrl);

      
    }catch(e){
      
    }
  }
}
