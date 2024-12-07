import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/auth/cubit/state.dart';
import 'package:lamassu/shared/components/local_database/sql_database.dart';

import '../../../models/user_model.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/components/get_device_info.dart';
import '../../../shared/end_point/end_point.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? User;
  void loginUser(String email, String Password) async {
    emit(LoginGetLoginLoadingState());

    try {
      var hashedPassword = sha512.convert(utf8.encode(Password)).toString();
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      var phoneId = await getPhoneId();

      var data = {
        "email": email,
        "password": hashedPassword,
        "center_id": CanterId,
        "auth_phone_id": phoneId.toString(),
        "auth_phone_details": await getDeviceInfo(),
        "auth_firebase": fcmToken
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      var dio = Dio();
      var response = await dio.post(
        'https://api.myexperience.center/api/mobile/auth/login',
        options: Options(headers: headers),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        SharedPreferences refre = await SharedPreferences.getInstance();
        refre.clear();
        var userData = UserModel.fromJson(response.data);
        User = userData;

        saveToken(userData.results.token);
        saveName(userData.results.name);
        savePhone(userData.results.phone);
        saveEmail(userData.results.email);
        SqlDatabase.db.insertAccountAsMap({
          "token": userData.results.token,
          "_id": userData.results.id,
          "name": userData.results.name,
          "phone": userData.results.phone,
          "type": userData.results.type == 'owner'
              ? 'owner'
              : userData.results.type == 'guard'
                  ? 'guard'
                  : userData.results.type == 'maintenance_emp'
                      ? 'maintenance'
                      : userData.results.type == 'tenant'
                          ? 'rent'
                          : userData.results.type == 'investor'
                              ? 'investor'
                              : 'sells_emp',
          "email": userData.results.email,
          "center_id": userData.results.centerId
        });

        emit(LoginGetLoginSuccessState(userData));
      } else {
        emit(
            LoginGetLoginErrorState(response.statusMessage ?? "Unknown error"));
      }
    } catch (error) {
      print(error);
      emit(LoginGetLoginErrorState("Error: $error"));
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<void> savePhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}
