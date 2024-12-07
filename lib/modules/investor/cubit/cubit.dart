import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/models/hoses_report_model.dart';
import 'package:lamassu/modules/investor/models/money_houses_model.dart';
import 'package:lamassu/modules/investor/models/security_clean_model.dart';
import 'package:lamassu/modules/investor/models/service_model.dart';
import 'package:lamassu/modules/investor/models/service_request_model.dart';
import 'package:lamassu/shared/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(HomeInitialState());

  static ReportCubit get(context) => BlocProvider.of(context);

  getHousesReport() async {
    emit(HouseLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        'investor/statistics/houses',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        ReportHouseModel house = ReportHouseModel.fromJson(jsonData["results"]);

        emit(HouseSuccessState(house));
      } else {
        emit(HouseErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(HouseErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }

  getHousesMoneyReport() async {
    emit(MoneyHousesLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        'investor/statistics/money',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        ReportMoneyModel money = ReportMoneyModel.fromJson(jsonData["results"]);

        emit(MoneyHousesSuccessState(money));
      } else {
        emit(MoneyHousesErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(MoneyHousesErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }

  getSecurityCleanReport() async {
    emit(SecurityCleanLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        'investor/statistics/monthly_bills',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        ReportSecurityCleanModel security =
            ReportSecurityCleanModel.fromJson(jsonData["results"]);

        emit(SecurityCleanSuccessState(security));
      } else {
        emit(SecurityCleanErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(SecurityCleanErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }

  getServiceReport() async {
    emit(ServiceLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        'investor/statistics/owner_salary_statistics',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        ReportServiceModel service =
            ReportServiceModel.fromJson(jsonData["results"]);

        emit(ServiceSuccessState(service));
      } else {
        emit(ServiceErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(ServiceErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }

  getServiceRequestReport() async {
    emit(ServiceRequestLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> headers = {
      'authorization': '$token',
    };

    try {
      var response = await performRequest(
        'GET',
        'investor/statistics/reservation_service',
        headers,
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;

        ReportServiceRequestModel security =
            ReportServiceRequestModel.fromJson(jsonData["results"]);

        emit(ServiceRequestSuccessState(security));
      } else {
        emit(ServiceRequestErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in catch error $e');
      emit(ServiceRequestErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }
}
