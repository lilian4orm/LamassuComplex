import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/VisitsModel.dart';
import 'package:http/http.dart' as http;
import 'package:lamassu/modules/visitors/state.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitsCubit extends Cubit<VisitordState> {
  VisitsCubit() : super(VisitordLoadingState());

  static VisitsCubit get(context) => BlocProvider.of(context);

  void fetchVisits() async {
    emit(VisitordLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      Map<String, String>? headers = {
        'authorization': '$token',
      };
      var response = await http.get(
          Uri.parse('${baseUrl}/owner/visits?page=1&limit=10000'),
          headers: headers);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        var finesList = VisitsModel.fromJson(data);
        emit(VisitordSuccessState(finesList));
      } else {
        emit(VisitordErrorState('هنالك خلل ما'));
      }
    } catch (e) {
      print('catch in monthly bills $e');
      emit(VisitordErrorState('هنالك خلل ما'));
    }
  }
}
