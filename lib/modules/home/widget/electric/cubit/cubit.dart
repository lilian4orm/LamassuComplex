import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/electric_model.dart';
import 'package:lamassu/modules/home/widget/electric/cubit/state.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:lamassu/shared/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectricCubit extends Cubit<ElectricState> {
  ElectricCubit() : super(ElectricLoadingState());

  static ElectricCubit get(context) => BlocProvider.of(context);

  ElectricModel? electric;

  void getElectricUsage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString('token');
    emit(ElectricLoadingState());

    var headers = {
      'center_id': CanterId,
      'Authorization': token,
    };

    try {
      var response = await performRequest(
        'GET',
        '$electricUsageLink',
        headers,
      );
      if (response.statusCode == 200) {
        if (response.data['error'] == false) {
          electric = ElectricModel.fromJson(response.data['results']);

          emit(ElectricSuccessState(electric));
        } else {
          emit(ElectricErrorState(response.data['message'] ?? 'error'));
        }
      } else {
        emit(ElectricErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      print('in cubit catch $e');
      emit(ElectricErrorState('Error: $e'));
    }
  }
}
