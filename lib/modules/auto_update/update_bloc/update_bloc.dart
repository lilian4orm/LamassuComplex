import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:lamassu/layout/navigation_bar/navigation_bar.dart';
import 'package:lamassu/modules/auth/onboarding.dart';
import 'package:lamassu/modules/auto_update/update_bloc/update_event.dart';
import 'package:lamassu/modules/auto_update/update_bloc/update_state.dart';
import 'package:lamassu/modules/maintenance/home_page.dart';
import 'package:lamassu/modules/security_guards/home_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateBloc extends Bloc<CheckUpdateEvent, MainUpdateState> {
  UpdateBloc() : super(UpdateLoadingState()) {
    on<CheckUpdateEvent>(checkForNewVersion);
  }

  static String link =
      'https://api.myexperience.center/api/mobile/app_versions/الروان';

  checkForNewVersion(
      CheckUpdateEvent event, Emitter<MainUpdateState> emit) async {
    emit(UpdateLoadingState());
    try {
      final response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final latestVersion = data['results']['version'];
        final currentVersion = await getCurrentVersion();

        bool isNewVersionAvailable = latestVersion != currentVersion;

        if (isNewVersionAvailable) {
          emit(UpdateDownloadState('جاري التنزيل ...'));
          String url = data['results']['url'];
          String contentUrl = data['content_url'];

          final filePath = await downloadNewVersion("$contentUrl$url");

          await installNewVersion(filePath);
        } else {
          emit(UpdateNoUpdateState('لديك أحدث إصدار'));
          redirectToPage();
        }
        return;
      }
      emit(UpdateErrorState('حدث خطأ ما'));
      return false;
    } catch (e) {
      emit(UpdateErrorState('حدث خطأ ما'));
      redirectToPage();
    }
  }

  redirectToPage() {}

  Future<String> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  Future<String> downloadNewVersion(String url) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/new_version.apk';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> requestInstallPackagesPermission() async {
    if (await Permission.requestInstallPackages.isDenied) {
      await Permission.requestInstallPackages.request();
    }
  }

  Future<void> installNewVersion(String filePath) async {
    await requestInstallPackagesPermission();

    try {
      await OpenFile.open(filePath);
    } catch (e) {}
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? owner = prefs.getString('owner');
    String? gest = prefs.getString('gest');
    String? guard = prefs.getString('guard');
    String? sells = prefs.getString('sells_emp');
    String? maintance = prefs.getString('maintenance');
    if (guard != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeGuardsScreen()),
      );
    } else if (owner != null || sells != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CustomNavBarWidget()),
      );
    } else if (gest != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CustomNavBarWidget()),
      );
    } else if (maintance != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MaintanceHome()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChooseSignIn()),
      );
    }
  }
}
