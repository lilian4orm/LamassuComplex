import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lamassu/modules/services/request_services/cubit/state.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceLoadingState());

  static ServiceCubit get(context) => BlocProvider.of(context);

  void fetchBills() async {
    emit(ServiceLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      Map<String, String>? headers = {
        'authorization': '$token',
      };

      var response = await http.get(
          Uri.parse('${baseUrl}reservations/service/fix/type'),
          headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['error'] == false) {
          var data = jsonDecode(response.body);
          var typleList = data['results'];
          var response2 = await http.get(
              Uri.parse('${baseUrl}reservations/service/house_rooms_names'),
              headers: headers);
          if (response2.statusCode == 200) {
            var data2 = json.decode(response2.body);
            if (data2['error'] == false) {
              List roomList = data2['results'];
              emit(ServiceSuccessState(typleList, roomList));
            }
          } else {
            emit(ServiceErrorState('هنالك خلل ما'));
          }
        }
      } else {
        emit(ServiceErrorState('هنالك خلل ما'));
      }
    } catch (e) {
      print('catch in monthly bills $e');
      emit(ServiceErrorState('هنالك خلل ما'));
    }
  }

  Future postService(Map<String, dynamic> data, List types, List romms) async {
    emit(ServiceLoadingState());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    Map<String, String>? headers = {
      'authorization': '$token',
      "center_id": CanterId,
      'Content-Type': 'application/json',
    };
   

    var response = await http.post(
      Uri.parse('${baseUrl}reservations/service'),
      body: jsonEncode(data),
      headers: headers,
    );
    var dataJson = jsonDecode(response.body);

   
    if (response.statusCode == 200) {
      if (dataJson['error'] == false) {
        emit(ServiceSuccessState(types, romms));
      } else {
        emit(ServiceErrorState(data['message']));
      }
    } else {
      emit(ServiceErrorState('هنالك خلل ما لم يتم الارسال'));
    }
  }
}
