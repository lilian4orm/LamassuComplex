import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/security_guards/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/check_qr_model.dart';
import '../../../models/owner_profile_model.dart';
import '../../../models/quard_visits.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';

class GuardsProfileCubit extends Cubit<GuardsProfileStates> {
  GuardsProfileCubit() : super(GuardsProfileInitialState());

  static GuardsProfileCubit get(context) => BlocProvider.of(context);

  OwnerProfileModel? GuardsProfile;
  GuardVisits? quardVisits;
  CheckQrModel? visitResponse;

  void getGuardsProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    emit(GuardsProfileGetLoadingState());
    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        '$guardProfileA',
        headers,
      );

      if (response.statusCode == 200) {
        var servicesModel = OwnerProfileModel.fromJson(response.data);

        if (servicesModel.results != null) {
          OwnerProfileModel GuardsProfile =
              OwnerProfileModel.fromJson(response.data);
          this.GuardsProfile = GuardsProfile;
          emit(GuardsProfileGetSuccessState(GuardsProfile));
        } else {
          emit(GuardsProfileGetErrorState(
              "Invalid response format: 'results' is null"));
        }
      } else {
        emit(GuardsProfileGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(GuardsProfileGetErrorState('Error: $e'));
    }
  }

  void updateGuardsProfileImage(BuildContext context) async {
    emit(updateGuardsProfileGetLoadingState());

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': token!,
        };

        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        var data = json.encode({
          "img": "data:image/jpeg;base64,$base64Image",
        });

        var dio = Dio();
        var response = await dio.put(
          'https://api.myexperience.center/api/mobile/guard/profile/edit_img',
          options: Options(
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          print(json.encode(response.data));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("تم تعديل الصوره بنجاح"),
              backgroundColor: Colors.green,
            ),
          );

          emit(updateGuardsProfileGetSuccessState());

          getGuardsProfile();
        } else {
          emit(updateGuardsProfileGetErrorState(
              response.statusMessage ?? 'Error'));
        }
      } catch (e) {
        emit(updateGuardsProfileGetErrorState(
            'Error updating profile image: $e'));
        print('Error updating profile image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("حدث خطا تاكد من اتصالك بلانترنت"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void postCheckQr(String codeQr, BuildContext context) async {
    emit(CheckQrLoadingState());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token is null');
      }

      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      Map<String, dynamic> data = {'code': codeQr};

      var response =
          await performRequest('POST', '$guardCheck_qr', headers, data: data);

      if (response.statusCode == 200) {
        if (response.data['error'] == true) {
          emit(CheckQrErrorState(response.data['message']));
          return;
        } else {
          final CheckQrModel reservationsModel =
              CheckQrModel.fromJson(response.data);
          visitResponse = reservationsModel;
          emit(CheckQrSuccessState(reservationsModel));
        }
      } else {
        emit(
            CheckQrErrorState(jsonDecode(response.data['message']) ?? "Error"));
      }
    } catch (e) {
      emit(CheckQrErrorState('Error: $e'));
    }
  }

  void getGuardVisits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    emit(GuardVisitsGetLoadingState());
    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        'guard/visits?page=1&limit=10000',
        headers,
      );

      if (response.statusCode == 200) {
        var GuardVisitsModel = GuardVisits.fromJson(response.data);

        if (GuardVisitsModel.results != null) {
          GuardVisits quardVisits = GuardVisits.fromJson(response.data);
          this.quardVisits = quardVisits;
          print("GuardsProfileGetLoadingState=====================");
          emit(GuardVisitsGetSuccessState(quardVisits));
        } else {
          emit(GuardVisitsGetErrorState(
              "Invalid response format: 'results' is null"));
        }
      } else {
        emit(GuardVisitsGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(GuardsProfileGetErrorState('Error: $e'));
    }
  }
}
