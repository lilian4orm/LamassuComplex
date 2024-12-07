import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/modules/auto_update/update_bloc/update_bloc.dart';
import 'package:lamassu/modules/auto_update/update_bloc/update_event.dart';
import 'package:lamassu/modules/investor/main_page.dart';
import 'package:lamassu/modules/maintenance/home_page.dart';
import 'package:lamassu/shared/components/language.dart';
import 'package:lamassu/shared/style/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layout/navigation_bar/navigation_bar.dart';
import 'modules/about_complex/cubit/cubit.dart';
import 'modules/auth/onboarding.dart';
import 'modules/favorite/cubit/cubit.dart';
import 'modules/form/cubit/cubit.dart';
import 'modules/home/cubit/cubit.dart';
import 'modules/notifications/cubit/cubit.dart';
import 'modules/profile/cubit/cubit.dart';
import 'modules/security_guards/home_qr_code.dart';
import 'modules/services/cubit/cubit.dart';
import 'my_firebase_notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
    // Handle the error appropriately, e.g., show an error message or retry initialization
  }
  NotificationFirebase notificationFirebase = NotificationFirebase();
  await notificationFirebase.initializeCloudMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  late Locale _appLocale = Locale("ar");

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  _loadLocale() async {
    _prefs = await SharedPreferences.getInstance();
    String? languageCode = _prefs.getString('languageCode');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
    } else {
      _appLocale = const Locale("ar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoriteCubit()..getFavorite()),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getHouses("", '')
              ..getAdvantages()
              ..getLastNews()
              ..getHouses("", "بيع")
              ..getHouses("", "ايجار")),
        BlocProvider(
            create: (context) => UpdateBloc()..add(CheckUpdateEvent())),
        BlocProvider(
            create: (context) => CenterCubit()
              ..getCenterReseid()
              ..getFormName()),
        BlocProvider(create: (context) => ServicesCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => OwnerProfileCubit()),
        BlocProvider(
            create: (context) => FormCubit()
              ..getFormName2()
              ..howHearAboutUs()
              ..getTowers()),
        BlocProvider(
            create: (context) => NotificationCubit()..getNotification()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          _appLocale = locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: _appLocale,
            supportedLocales: const [
              Locale("ar"),
              Locale("en"),
            ],
            theme: getThemeDataLight(context),
            // home: SplashScreenWellcome(),
            home: MyAppHomePage(),
          );
        },
      ),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  const MyAppHomePage({Key? key}) : super(key: key);

  @override
  _MyAppHomePageState createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  String? token;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    String? owner = prefs.getString('owner');
    String? gest = prefs.getString('gest');
    String? guard = prefs.getString('guard');
    String? sells = prefs.getString('sells_emp');
    String? maintance = prefs.getString('maintenance');
    String? rent = prefs.getString('rent');
    String? investor = prefs.getString('investor');

    if (guard != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeGuardsScreen()),
      );
    }
    if (investor != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InvestorMainPage()),
      );
    } else if (owner != null || sells != null || rent != null) {
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
