import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/monthly_bills_model.dart';
import 'package:lamassu/modules/monthly_bills/bills_bloc/bills_state.dart';
import 'package:http/http.dart' as http;
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillsCubit extends Cubit<BillsState> {
  BillsCubit() : super(BillsLoadingState());

  static BillsCubit get(context) => BlocProvider.of(context);

  void fetchBills() async {
    emit(BillsLoadingState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      Map<String, String>? headers = {
        'authorization': '$token',
      };
      var response = await http.get(
          Uri.parse('${baseUrl}owner/monthly_bill_service?page=1&limit=1000'),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var billList = (data['results']['data'] as List)
            .map((e) => MonthlyBillsModel.fromJson(e))
            .toList();
        emit(BillsSuccessState(billList));
      } else {
        emit(BillsErrorState('هنالك خلل ما'));
      }
    } catch (e) {
      print('catch in monthly bills $e');
      emit(BillsErrorState('هنالك خلل ما'));
    }
  }
}
