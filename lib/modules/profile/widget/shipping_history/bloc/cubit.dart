import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/bloc/state.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/models/shipping_model.dart';

import 'package:lamassu/shared/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogShippingCubit extends Cubit<LogStates> {
  LogShippingCubit() : super(LogInitialState());

  static LogShippingCubit get(context) => BlocProvider.of(context);

  getShippingLog(int page) async {
    emit(ShippingLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        '/reservations/service/reservation/شحن?page=$page&limit=10',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        List<ShipingResponeModel> logList = [];
        for (var item in jsonData['results']['data']) {
          logList.add(ShipingResponeModel.fromJson(item));
        }

        emit(ShippingSuccessState(logList));
      } else {
        emit(ShippingErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(ShippingErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }

  getServiceLog(int page) async {
    emit(ServiceLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        '/reservations/service/reservation/صيانة?page=$page&limit=10',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        List<ShipingResponeModel> logList = [];
        for (var item in jsonData['results']['data']) {
          logList.add(ShipingResponeModel.fromJson(item));
        }

        emit(ServiceSuccessState(logList));
      } else {
        emit(ServiceErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(ServiceErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }
}
