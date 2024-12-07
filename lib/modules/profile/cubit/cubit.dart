import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/profile/cubit/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/VisitsModel.dart';
import '../../../models/about_app_model.dart';
import '../../../models/owner_profile_model.dart';
import '../../../shared/remote/dio_helper.dart';

class OwnerProfileCubit extends Cubit<OwnerProfileStates> {
  OwnerProfileCubit() : super(OwnerProfileInitialState());

  static OwnerProfileCubit get(context) => BlocProvider.of(context);

  OwnerProfileModel? ownerProfile;
  VisitsModel? ownerVisits;
  AboutAppModel? aboutApp;

  void getOwnerProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? sells = prefs.getString('sells_emp');
    String? rent = prefs.getString('rent');

    emit(OwnerProfileGetLoadingState());
    try {
      var headers = {'Authorization': token};
      var response = await performRequest(
        'GET',
        sells != null
            ? 'sellsEmployee/profile'
            : rent == null
                ? 'owner/profile'
                : 'tenant/profile',
        // sells == null
        //     ? '$ownerProfileA'
        //     : rent == null
        //         ? '$sellsEmployeeProfile'
        //         : '$rentProfileA',
        headers,
      );

      if (response.statusCode == 200) {
        var servicesModel = OwnerProfileModel.fromJson(response.data);

        if (servicesModel.results != null) {
          OwnerProfileModel ownerProfile =
              OwnerProfileModel.fromJson(response.data);
          this.ownerProfile = ownerProfile;

          emit(OwnerProfileGetSuccessState(ownerProfile));
        } else {
          emit(OwnerProfileGetErrorState(
              "Invalid response format: 'results' is null"));
        }
      } else {
        emit(OwnerProfileGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(OwnerProfileGetErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  void updateProfileImage(BuildContext context) async {
    emit(updateProfileGetLoadingState());

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        String? sells = prefs.getString('sells_emp');
        String? rent = prefs.getString('rent');

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
          sells == null
              ? 'https://api.myexperience.center/api/mobile/owner/profile/edit_img'
              : rent == null
                  ? 'https://api.myexperience.center/api/mobile/sellsEmployee/profile/edit_img'
                  : 'https://api.myexperience.center/api/mobile/tenant/profile/edit_img',
          options: Options(
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("تم تعديل الصوره بنجاح"),
              backgroundColor: Colors.green,
            ),
          );

          emit(updateProfileGetSuccessState());

          getOwnerProfile();
        } else {
          emit(updateProfileGetErrorState(response.statusMessage ?? 'Error'));
        }
      } catch (e) {
        emit(updateProfileGetErrorState('Error updating profile image: $e'));
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

  void getOwnerVisits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    emit(OwnerVisitsGetLoadingState());
    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        "owner/visits",
        headers,
      );

      if (response.statusCode == 200) {
        VisitsModel ownerVisitss = VisitsModel.fromJson(response.data);
        print(response.data);

        emit(OwnerVisitsGetSuccessState(ownerVisitss));
      } else {
        emit(OwnerVisitsGetErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(OwnerVisitsGetErrorState('Error: $e'));
      print('Error: $e');
    }
  }

  void getaboutApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    emit(AboutAppLoadingState());
    try {
      var headers = {'Authorization': token};

      var response = await performRequest(
        'GET',
        "about_us_lamassu",
        headers,
      );

      if (response.statusCode == 200) {
        AboutAppModel aboutAppModel = AboutAppModel.fromJson(response.data);
        aboutApp = aboutAppModel;

        emit(AboutAppSuccessState(aboutAppModel));
      } else {
        emit(AboutAppErrorState(response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(AboutAppErrorState('Error: $e'));
    }
  }

  void postComplain({
    required String title,
    required String description,
    required String type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(complainLoadingState());

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var data = {
      "title": title,
      "description": description,
      "type": type,
    };

    try {
      var response = await performRequest(
        'POST',
        'complain',
        headers,
        data: data,
      );

      if (response.statusCode == 200) {
        emit(complainSuccessState());
      } else {
        emit(complainErrorState(response.statusMessage ?? "Error"));
      }
    } catch (e) {
      emit(complainErrorState("Error: $e"));
      print("Error: $e");
    }
  }
}
