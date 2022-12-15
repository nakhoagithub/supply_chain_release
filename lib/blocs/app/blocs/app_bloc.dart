import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain/blocs/app/app.dart';

import '../../../enum.dart';


class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState(appStatus: AppStatus.initialize)) {
    on<AppInitialEvent>((event, emit) => _onAppInitEvent(event, emit));
  }

  void _onAppInitEvent(AppInitialEvent event, Emitter<AppState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? privateKey = sharedPreferences.getString("privateKey");
    await Future.delayed(const Duration(milliseconds: 2500));
    if (privateKey != null && privateKey.isNotEmpty) {
      emit(state.copyWith(
          appStatus: AppStatus.authentication, privateKey: privateKey));
    } else {
      emit(state.copyWith(appStatus: AppStatus.unauthentication));
    }
  }
}
