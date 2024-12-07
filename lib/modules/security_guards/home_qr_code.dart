import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lamassu/modules/security_guards/visitor_log.dart';
import 'package:lamassu/modules/security_guards/widget/read_qr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import '../../gen/assets.gen.dart';
import '../../shared/components/loading.dart';
import '../../shared/components/logout_user.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'guard_salary.dart';

class HomeGuardsScreen extends StatefulWidget {
  const HomeGuardsScreen({Key? key});

  @override
  State<HomeGuardsScreen> createState() => _HomeGuardsScreenState();
}

class _HomeGuardsScreenState extends State<HomeGuardsScreen> {
  String? scanBarcode = "";
  late SharedPreferences prefs;

  String? token;
  String? name;
  String? phone;
  String? gest;
  String? owner;
  String? guard;
  String? maintance;
  String? sells;
  String? phoneComplex;
  List<String>? housesIds;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      name = prefs.getString('name');
      phone = prefs.getString('phone');
      gest = prefs.getString('gest');
      owner = prefs.getString('owner');
      guard = prefs.getString('guard');
      maintance = prefs.getString('maintenance');
      sells = prefs.getString('sells_emp');
      phoneComplex = prefs.getString('phoneComplex');
      housesIds = prefs.getStringList('houses_ids');
    });
  }

  Future<void> scanQR(BuildContext context) async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#C3922E',
        'الغاء',
        true,
        ScanMode.QR,
      );

      if (barcodeScanRes.isNotEmpty) {
        context.read<GuardsProfileCubit>().postCheckQr(barcodeScanRes, context);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return loadingDialog();
          },
        );
        Navigator.of(context).pop();
      }

      setState(() {
        scanBarcode = barcodeScanRes;
      });
    } on PlatformException {
      setState(() {
        scanBarcode = 'Failed to get platform version.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.brandPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorName.brandPrimary,
        title: Text(
          AppLocalizations.of(context)!.nahda_residential_complex,
          style: const TextStyle(
            color: ColorName.secondaryLight,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Assets.svgs.logo3.svg(height: 30),
        // ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 50,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()),
                );
              },
              child: Assets.svgs.bell.svg(color: ColorName.secondaryLight),
            ),
          ),
        ],
      ),
      body: BlocProvider(
          create: (context) => GuardsProfileCubit(),
          child: BlocConsumer<GuardsProfileCubit, GuardsProfileStates>(
            listener: (context, state) {
              if (state is CheckQrLoadingState) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("انتظر من فضلك"),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is CheckQrSuccessState) {
                Navigator.of(context).pop();

                final printName =
                    GuardsProfileCubit.get(context).visitResponse!;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadQrScreen(
                              readCheckQr: printName,
                            )));
              }
              if (state is CheckQrErrorState) {
                Navigator.of(context).pop();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('asset/lottie/errorlod.json',
                              height: 180),
                          SizedBox(height: 8),
                          Text(
                            state.error,
                            style: const TextStyle(
                              color: ColorName.brandPrimary,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                ColorName.brandPrimary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "موافق",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ColorName.secondaryLight,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                    ),
                    color: ColorName.secondaryLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => scanQR(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: ColorName.SecandaryYallw1,
                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Assets.svgs.add.svg(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .please_scan_the_visitor_add_button,
                          style: const TextStyle(
                            color: ColorName.NuturalColor4,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      drawer: BlocProvider(
        create: (context) => GuardsProfileCubit()
          ..getGuardsProfile()
          ..getGuardVisits(),
        child: BlocConsumer<GuardsProfileCubit, GuardsProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var profile = GuardsProfileCubit.get(context).GuardsProfile;
            var viseter = GuardsProfileCubit.get(context).quardVisits;
            if (state is updateGuardsProfileGetLoadingState ||
                profile == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Drawer(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    color: ColorName.brandPrimary,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Assets.svgs.logop.svg(fit: BoxFit.cover),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorName.NuturalColor1,
                              child: InkWell(
                                onTap: () {
                                  GuardsProfileCubit.get(context)
                                      .updateGuardsProfileImage(context);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: ColorName.NuturalColor1,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          height: double.infinity,
                                          width: double.infinity,
                                          imageUrl: profile.contentUrl! +
                                              "${profile.results!.image}",
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Assets.images.logo.image(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: ColorName.brandPrimary,
                                        child: SvgPicture.asset(
                                          "asset/svgs/Subtract.svg",
                                          height: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              profile.results!.name!,
                              style: TextStyle(
                                  color: ColorName.secondaryLight,
                                  fontSize: Sizes.fontDefault,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: ColorName.SecandaryYallw4),
                            ),
                            SizedBox(height: 8),
                            Text(
                              profile.results!.phone!,
                              style: TextStyle(
                                color: ColorName.NuturalColor1,
                                fontSize: Sizes.fontDefault,
                                fontWeight: FontWeight.w500,
                                backgroundColor: ColorName.SecandaryYallw4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // profileRowWidget(
                        //   context: context,
                        //   text: "الحضور",
                        //   onTap: () {
                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AudienceScreen()));
                        //   },
                        // ),
                        profileRowWidget(
                          context: context,
                          text: AppLocalizations.of(context)!.salary,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GuardSalaryScreen(
                                      salary: profile,
                                    )));
                          },
                        ),
                        profileRowWidget(
                          context: context,
                          text: "سجل الزائرين",
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VisitorLogScreen(
                                      cubit: viseter,
                                    )));
                          },
                        ),
                        profileRowWidget(
                            context: context,
                            text: AppLocalizations.of(context)!.log_out,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return logoutAlertDialog(context, true);
                                },
                              );
                            },
                            icon: Assets.svgs.logout.svg()),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget logoutAlertDialog(BuildContext context, bool bottom) {
    return AlertDialog(
      title: Assets.images.logo.image(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      content: Text(
        bottom == true
            ? AppLocalizations.of(context)!.do_you_really_want_to_log_out
            : AppLocalizations.of(context)!.do_you_want_to_log_in,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: ColorName.NuturalColor6,
            ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              ColorName.NuturalColor6,
            ),
          ),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                });
            logoutUser(token, context, name, phone, owner, guard, maintance,
                sells, housesIds);
          },
          child: Text(
            bottom == true
                ? AppLocalizations.of(context)!.log_out
                : AppLocalizations.of(context)!.login,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorName.secondaryLight,
                ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        if (bottom == true)
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                ColorName.NuturalColor2,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorName.NuturalColor6,
                  ),
            ),
          ),
      ],
    );
  }
}
