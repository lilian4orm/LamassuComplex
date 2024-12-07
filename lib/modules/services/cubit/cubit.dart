import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/services/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/qr_generate_model.dart';
import '../../../models/reservations_service_model.dart';
import '../../../models/salary_owner_services_model.dart';
import '../../../models/services_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';

class ServicesCubit extends Cubit<ServicesStates> {
  ServicesCubit() : super(ServicesInitialState());

  static ServicesCubit get(context) => BlocProvider.of(context);

  List<ServicesResults>? services = [];
  List<ServicesResults>? services2 = [];

  void getServices(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    emit(ServicesGetLoadingState());
    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        'services',
        headers,
        queryParameters: {'type': type},
      );

      if (response.statusCode == 200) {
        var servicesModel = ServicesModel.fromJson(response.data);

        if (servicesModel.results != null) {
          List<ServicesResults> results = servicesModel.results!;

          if (type == "صيانة") {
            this.services = results;
          }
          if (type == "شحن") {
            this.services2 = results;
          }

          emit(ServicesGetSuccessState(results));
        } else {
          emit(ServicesGetErrorState(
              "Invalid response format: 'results' is null"));
        }
      } else {
        emit(ServicesGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(ServicesGetErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  bool? isSelected;
  void postReservationsService(
      String name, String phone, String serviceId, String note) async {
    emit(ServicesReservationsGetLoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    var headers = {
      'center_id': CanterId,
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var data = {
      "name": name,
      "phone": phone,
      "address": "مجمع الروان السكني",
      "service_id": serviceId,
      "center_id": CanterId,
      "note": note
    };

    try {
      var response = await performRequest(
        'POST',
        '$reservationsService',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        final ReservationsServiceModel reservationsModel =
            ReservationsServiceModel.fromJson(response.data);
        emit(ServicesReservationsGetSuccessState(reservationsModel));
      } else {
        emit(ServicesReservationsGetErrorState(
            response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(ServicesReservationsGetErrorState("Error: $e"));
      print("Error: $e");
    }
  }

  SalaryServicesModel? invoices;

  void getInvoices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(ServicesInvoicesGetLoadingState());

    try {
      var headers = {'Authorization': token};

      var response =
          await performRequest('GET', '$salaryOwnerServices', headers);

      if (response.statusCode == 200) {
        List<ResultsSalary> resultsList = (response.data['results'] as List)
            .map((json) => ResultsSalary.fromJson(json))
            .toList();

        // Check if 'statistics' is nested inside another field
        Statistics? statistics;
        if (response.data['nested_field'] != null &&
            response.data['nested_field']['statistics'] != null) {
          statistics =
              Statistics.fromJson(response.data['nested_field']['statistics']);
        } else {
          statistics = response.data['statistics'] != null
              ? Statistics.fromJson(response.data['statistics'])
              : null;
        }

        SalaryServicesModel invoices = SalaryServicesModel(
          results: resultsList,
          statistics: statistics,
        );

        this.invoices = invoices;
        emit(ServicesInvoicesGetSuccessState(invoices));
      } else {
        emit(ServicesInvoicesGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(ServicesInvoicesGetErrorState('Error: $e'));
    }
  }

  QrGenerate? qrGenerate;
  void QrGenerateGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(QrGenerateGetLoadingState());

    try {
      var headers = {'Authorization': token};

      var response = await performRequest('GET', '$ownerQrGenerate', headers);

      if (response.statusCode == 200) {
        qrGenerate = QrGenerate.fromJson(response.data);

        emit(QrGenerateGetSuccessState(qrGenerate!));
      } else {
        emit(QrGenerateGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(QrGenerateGetErrorState('Error: $e'));
    }
  }
}
