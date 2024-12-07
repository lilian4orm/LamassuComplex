import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/fines_model.dart';
import 'package:lamassu/modules/fines/state.dart';
import 'package:http/http.dart' as http;
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinesCubit extends Cubit<FinesState> {
  FinesCubit() : super(FinesLoadingState());

  static FinesCubit get(context) => BlocProvider.of(context);

  void fetchFines() async {
    emit(FinesLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      Map<String, String>? headers = {
        'authorization': '$token',
      };
      var response = await http.get(
          Uri.parse('${baseUrl}/owner/fines?page=1&limit=10000'),
          headers: headers);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        var finesList = (data['results']['data'] as List)
            .map((e) => FinesModel.fromJson(e))
            .toList();
        emit(FinesSuccessState(finesList));
      } else {
        emit(FinesErrorState('هنالك خلل في الاتصال بالانترنيت'));
      }
    } catch (e) {
      print('catch in monthly bills $e');
      emit(FinesErrorState('هنالك خلل في الاتصال بالانترنيت'));
    }
  }
}
