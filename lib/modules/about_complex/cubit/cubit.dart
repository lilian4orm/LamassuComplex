import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/canter_model.dart';
import 'package:lamassu/modules/about_complex/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/form_model/form_houses_and_rooms.dart';
import '../../../models/form_model/form_name.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';

class CenterCubit extends Cubit<CenterStates> {
  CenterCubit() : super(CenterInitialState());

  static CenterCubit get(context) => BlocProvider.of(context);

  Results? center;

  void getCenterReseid() async {
    // Corrected function name and parameter
    emit(CenterGetcenterLoadingState());
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest('GET', centerA, headers);

      var centerData = MyExperienceModel.fromJson(response.data);
      this.center = centerData.results;

      emit(CenterGetcenterSuccessState(centerData.results));
    } catch (e) {
      emit(CenterGetcenterErrorState('Error: $e'));
    }
  }

  Future<void> savePhoneComplex(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneComplex', phone);
  }

  FormNameModel? FormName;

  void getFormName() async {
    emit(FormNameLoadingState());
    print("FormNameLoadingState");
    // print('==================');
    // print('center id : $CanterId');
    try {
      var headers = {
        'center_id': CanterId,
      };
      // print('headers = $headers');
      var response = await performRequest('GET', centerFormsNames, headers);
      // print("Response status code: ${response.statusCode}");
      // print("Response data: ${response.data}");
      if (response.statusCode == 200) {
        FormName = FormNameModel.fromJson(response.data);
        this.FormName = FormName;
        print(FormName!.results!.first.name!);

        emit(FormNameSuccessState(FormName));
      } else {
        emit(FormNameErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (e) {
      emit(FormNameErrorState('Error: $e'));
    }
  }

  HousesandRoomModel? HouseName;
  void getHouseName({required String? id}) async {
    emit(HouseNameLoadingState());
    print("FormNameLoadingState");
    try {
      var headers = {
        'center_id': CanterId,
      };

      var response = await performRequest(
          'GET', "/center/forms/houses/rooms/$id", headers);

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        HouseName = HousesandRoomModel.fromJson(response.data);
        this.HouseName = HouseName;
        print("HouseNameSuccessState");
        print(HouseName!.results!.first.name!);

        emit(HouseNameSuccessState(HouseName));
      } else {
        emit(HouseNameErrorState('Error: Status code ${response.statusCode}'));
        print("uyfdvutcyfveuyfbcvf");
      }
    } catch (e) {
      print("Error in HouseName: $e");
      emit(HouseNameErrorState('Error: $e'));
    }
  }
}
