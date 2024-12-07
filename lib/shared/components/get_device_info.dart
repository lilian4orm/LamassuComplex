import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_device_id/flutter_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  token = prefs.getString('token')!;
}


Future<String?> getPhoneId() async {
  final _flutterDeviceIdPlugin = FlutterDeviceId();

  String? deviceId = await _flutterDeviceIdPlugin.getDeviceId() ?? '';
  return deviceId;
}
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

getDeviceInfo() async {

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return "${androidInfo.manufacturer}, ${androidInfo.brand}, ${androidInfo.model}, ${androidInfo.board}";
  } else if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return "${iosDeviceInfo.utsname.machine}, ${iosDeviceInfo.utsname.sysname}, ${iosDeviceInfo.model}";
  } else {
    return "NoData";
  }
}