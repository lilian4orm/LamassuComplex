import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:lamassu/layout/navigation_bar/navigation_bar.dart';
import 'package:lamassu/modules/auth/onboarding.dart';
import 'package:lamassu/modules/maintenance/home_page.dart';
import 'package:lamassu/modules/security_guards/home_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenWellcome extends StatefulWidget {
  const SplashScreenWellcome({super.key});

  @override
  State<SplashScreenWellcome> createState() => _SplashScreenWellcomeState();
}

class _SplashScreenWellcomeState extends State<SplashScreenWellcome> {
  static String text = 'جاري البحث عن تحديثات جديدة';
  static String link =
      'https://api.myexperience.center/api/mobile/app_versions/الروان';

  @override
  void initState() {
    checkForNewVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('asset/images/logo.png'),
            loadingWidget(),
          ],
        ),
      ),
    );
  }

  loadingWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Center(child: const CircularProgressIndicator())
        ],
      ),
    );
  }

  checkForNewVersion() async {
    try {
      final response = await http.get(Uri.parse(link));
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final latestVersion = data['results']['version'];
        final currentVersion = await getCurrentVersion();

        bool isNewVersionAvailable = latestVersion != currentVersion;

        if (isNewVersionAvailable) {
          String url = data['results']['url'];
          String contentUrl = data['content_url'];

          setState(() {
            text = 'جاري تحميل التحديث الجديد';
          });
          final filePath = await downloadNewVersion("$contentUrl$url");

          await installNewVersion(filePath);
        } else {
          redirectToPage();
        }
        return;
      } else {
        redirectToPage();
      }
    } catch (e) {
      redirectToPage();
    }
  }

  redirectToPage() async {
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
    } else if (await Permission.requestInstallPackages.isPermanentlyDenied) {
      openAppSettings();
    } else {
      redirectToPage();
    }
  }

  Future<void> installNewVersion(String filePath) async {
    await requestInstallPackagesPermission();

    try {
      await OpenFile.open(filePath);
    } catch (e) {
      redirectToPage();
    }
  }
}
