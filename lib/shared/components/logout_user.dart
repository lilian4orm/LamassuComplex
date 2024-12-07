import 'package:flutter/material.dart';
import 'package:lamassu/shared/components/local_database/sql_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/auth/login_screen.dart';
import '../remote/dio_helper.dart';

Future<void> logoutUser(
    String? token,
    BuildContext context,
    String? name,
    String? phone,
    String? owner,
    String? guard,
    String? maintance,
    String? sells,
    List<String>? housesIds) async {
  late SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
  String? email;
  token = prefs.getString('token');
  name = prefs.getString('name');
  phone = prefs.getString('phone');
  owner = prefs.getString('owner');
  guard = prefs.getString('guard');
  email = prefs.getString('email');
  maintance = prefs.getString('maintenance');
  sells = prefs.getString('sells_emp');
  housesIds = prefs.getStringList('houses_ids');

  Future<void> removeToken() async {
    await prefs.remove('token');
    prefs.clear();
  }

  Future<void> languageCode1() async {
    await prefs.remove('languageCode');
  }

  Future<void> removeMaintance() async {
    await prefs.remove('maintenance');
  }

  Future<void> removeName() async {
    await prefs.remove('name');
  }

  Future<void> removeHousId() async {
    await prefs.remove('houses_ids');
  }

  Future<void> removeGuard() async {
    await prefs.remove('guard');
  }

  Future<void> removeOwner() async {
    await prefs.remove('owner');
  }

  Future<void> removeRent() async {
    await prefs.remove('rent');
  }

  Future<void> removePhone() async {
    await prefs.remove('phone');
  }

  Future<void> removeSells() async {
    await prefs.remove('sells_emp');
  }

  try {
    var headers = {'Authorization': token};

    var response = await performRequest(
      'GET',
      'auth/logout',
      headers,
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);

      await removeName();
      await removePhone();
      await removeToken();
      await removeOwner();
      await removeGuard();
      await removeSells();
      await removeMaintance();
      await languageCode1();
      await removeHousId();
      await removeRent();
      SqlDatabase().deleteAccount(email!);
    } else {
      print(
          'Logout failed: ${response.statusCode} - ${response.statusMessage}');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطا"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    print('Error during logout: $e');
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("حدث خطا"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
