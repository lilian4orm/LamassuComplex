import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/account_statement/cubit/state.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/salary_owner_model.dart';
import '../../../shared/remote/dio_helper.dart';

class PaymentsCubit extends Cubit<PaymentsStates> {
  PaymentsCubit() : super(PaymentsInitialState());

  static PaymentsCubit get(context) => BlocProvider.of(context);

  SalaryOwnerModel? payments;

  void getPayments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(PaymentsGetWonerLoadingState());

    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        '$salaryOwner',
        headers,
      );

      if (response.statusCode == 200) {
        List<Results> resultsList = (response.data['results'] as List)
            .map((json) => Results.fromJson(json))
            .toList();
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

        SalaryOwnerModel payments = SalaryOwnerModel(
          results: resultsList,
          statistics: statistics,
        );

        print(response.data['results']);
        this.payments = payments;
        print(payments);

        print('PaymentsGetWonerSuccessState: $payments');

        emit(PaymentsGetWonerSuccessState(payments));
      } else {
        emit(PaymentsGetWonerErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(PaymentsGetWonerErrorState('Error: $e'));
    }
  }
}
