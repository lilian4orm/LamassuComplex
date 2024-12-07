import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/modules/accounts/accounts_screen.dart';
import 'package:lamassu/modules/fines/fines_screen.dart';

import 'package:lamassu/modules/monthly_bills/monthly_bills_screen.dart';
import 'package:lamassu/modules/profile/widget/apply_form.dart';
import 'package:lamassu/modules/profile/widget/complain_screen.dart';
import 'package:lamassu/modules/auth/login_screen.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/tab_main.dart';
import 'package:lamassu/modules/visitors/visits_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gen/assets.gen.dart';
import '../../shared/components/language.dart';
import '../../shared/components/logout_user.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../about_complex/about_complex.dart';
import '../account_statement/account_statement_screen.dart';
import '../security_guards/guard_salary.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;

  String? token;
  String? name;
  String? phone;
  String? gest;
  String? owner;
  String? guard;
  String? maintance;
  String? sells;
  String? rent;
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
      rent = prefs.getString('rent');
      guard = prefs.getString('guard');
      maintance = prefs.getString('maintenance');
      sells = prefs.getString('sells_emp');
      phoneComplex = prefs.getString('phoneComplex');
      housesIds = prefs.getStringList('houses_ids');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: token == null ? Colors.black.withOpacity(0.3) : null,
        appBar: AppBar(
          backgroundColor: token == null ? Colors.black.withOpacity(0.1) : null,
          title: Text(
            AppLocalizations.of(context)!.personal_account,
            style: const TextStyle(
              color: ColorName.NuturalColor6,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: token == null
            ? logoutAlertDialog(context, false)
            : BlocProvider(
                create: (context) => OwnerProfileCubit()
                  ..getaboutApp()
                  ..getOwnerProfile()
                  ..getOwnerVisits(),
                child: BlocConsumer<OwnerProfileCubit, OwnerProfileStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var profile = OwnerProfileCubit.get(context).ownerProfile;
                    //  var profileww = OwnerProfileCubit.get(context).aboutApp;

                    if (state is OwnerProfileGetLoadingState ||
                        profile == null) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is OwnerProfileGetErrorState) {
                      return Center(
                          child: PlaceHolderWidget(
                              context: context,
                              title: 'لاتوجد بيانات',
                              image: Assets.illustrations.house.svg()));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 7,
                              color: ColorName.NuturalColor1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                profile.results!.name!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                      ColorName.NuturalColor6,
                                                  fontSize: Sizes.fontDefault,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          owner == null && rent == null
                                              ? SizedBox()
                                              : Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                'البناية :',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                profile.results!
                                                                        .buildingNo ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                'الطابق :',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                profile.results!
                                                                        .floor ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                'الشقة :',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                profile.results!
                                                                        .houseNo ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorName
                                                                      .NuturalColor4,
                                                                  fontSize: Sizes
                                                                      .fontSmall,
                                                                  //fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  InkWell(
                                    onTap: () {
                                      OwnerProfileCubit.get(context)
                                          .updateProfileImage(context);
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          margin: EdgeInsets.only(left: 10),
                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: ColorName.NuturalColor1,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: profile.results!.image ==
                                                    null
                                                ? Image.asset('asset/logo.jpg')
                                                : CachedNetworkImage(
                                                    imageUrl: profile
                                                            .contentUrl! +
                                                        "${profile.results!.image}",
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Assets.images.logo
                                                                .image(),
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 10),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.9),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'تغيير الصورة',
                                              style: TextStyle(fontSize: 10),
                                            ))
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 12),

                                  // SizedBox(height: 8),
                                  // Text(
                                  //   profile.results!.phone!,
                                  //   style: TextStyle(
                                  //     color: ColorName.SecandaryYallw2,
                                  //     fontSize: Sizes.fontDefault,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   profile.results!.address!,
                                  //   style: TextStyle(
                                  //     color: ColorName.SecandaryYallw2
                                  //         .withOpacity(0.5),
                                  //     fontSize: Sizes.fontDefault,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              child: Column(
                                children: [
                                  if (sells == null && rent == null)
                                    profileRowWidget(
                                      context: context,
                                      text: AppLocalizations.of(context)!
                                          .sales_and_rent_payments,
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              AccountStatementScreen(),
                                        ));
                                      },
                                    ),
                                  // if (sells == null)
                                  //   profileRowWidget(
                                  //     context: context,
                                  //     text: AppLocalizations.of(context)!
                                  //         .service_bills,
                                  //     onTap: () {
                                  //       Navigator.of(context)
                                  //           .push(MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             InvoicesScreen(),
                                  //       ));
                                  //     },
                                  //   ),
                                  if (sells != null)
                                    profileRowWidget(
                                      context: context,
                                      text:
                                          AppLocalizations.of(context)!.salary,
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              GuardSalaryScreen(
                                            salary: profile,
                                          ),
                                        ));
                                      },
                                    ),
                                  // if (sells == null)
                                  //   profileRowWidget(
                                  //     context: context,
                                  //     text: AppLocalizations.of(context)!
                                  //         .visitors,
                                  //     onTap: () {
                                  //       Navigator.of(context)
                                  //           .push(MaterialPageRoute(
                                  //         builder: (context) => VisitsScreen(
                                  //           cubit:
                                  //               OwnerProfileCubit.get(context)
                                  //                   .ownerVisits,
                                  //         ),
                                  //       ));
                                  //     },
                                  //   ),
                                  owner != null && rent != null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: "المجمع",
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  AboutTheComplex(),
                                            ));
                                          },
                                        ),
                                  sells != null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: "الفواتير الشهرية",
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  MonthlyBillsScreen(),
                                            ));
                                          },
                                        ),
                                  sells != null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: "الغرامات الشهرية",
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  FinesScreen(),
                                            ));
                                          },
                                        ),
                                  owner == null && rent == null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: 'الزوار',
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VisitsScreen()));
                                          },
                                        ),

                                  owner == null && rent == null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: 'استمارة الطلبات',
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApplyFormScreenOwner()));
                                          },
                                        ),
                                  owner == null && rent == null
                                      ? SizedBox()
                                      : profileRowWidget(
                                          context: context,
                                          text: 'سجل الصيانة والشحن',
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LogServiceScreen()));
                                          },
                                        ),
                                  profileRowWidget(
                                    context: context,
                                    text: 'أضافة حساب',
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountsScreen()));
                                    },
                                  ),
                                  // profileRowWidget(

                                  //   context: context,
                                  //   text: AppLocalizations.of(context)!.currency_conversion,
                                  //   onTap: () {},
                                  // ),
                                  // profileRowWidget(
                                  //   context: context,
                                  //   text: AppLocalizations.of(context)!
                                  //       .community_engagement,
                                  //   onTap: () {
                                  //     Navigator.of(context)
                                  //         .push(MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           SocialCommunication(),
                                  //     ));
                                  //   },
                                  // ),

                                  profileRowWidget(
                                    context: context,
                                    text: AppLocalizations.of(context)!
                                        .make_complaint,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => complainScreen(),
                                      ));
                                    },
                                  ),

                                  // profileRowWidget(
                                  //   context: context,
                                  //   text: AppLocalizations.of(context)!
                                  //       .about_application,
                                  //   onTap: () {
                                  //     Navigator.of(context)
                                  //         .push(MaterialPageRoute(
                                  //       builder: (context) => AboutApp(
                                  //         cubit: profileww,
                                  //       ),
                                  //     ));
                                  //   },
                                  // ),
                                  // profileRowWidget(
                                  //   context: context,
                                  //   text: AppLocalizations.of(context)!
                                  //       .technical_support,
                                  //   onTap: () {
                                  //     launchWhatsApp(phoneComplex.toString());
                                  //   },
                                  // ),
                                  profileRowWidget(
                                      context: context,
                                      text:
                                          AppLocalizations.of(context)!.log_out,
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return logoutAlertDialog(
                                                context, true);
                                          },
                                        );
                                      },
                                      icon: Assets.svgs.logout.svg()),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ));
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blue),
                  title: const Text(
                    'العربية',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    BlocProvider.of<LanguageCubit>(context)
                        .changeLanguage(const Locale("ar"));
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blue),
                  title: const Text(
                    'English',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    BlocProvider.of<LanguageCubit>(context)
                        .changeLanguage(const Locale("en"));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget logoutAlertDialog(BuildContext context, bool bottom) {
    return AlertDialog(
      title: Container(
        height: MediaQuery.of(context).size.width * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: ColorName.NuturalColor5,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'asset/logo.jpg',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
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
            if (bottom == true) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  });
              logoutUser(token, context, name, phone, owner, guard, maintance,
                  sells, housesIds);
            } else {
              await removeGest();
              await removeHousId();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            }
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

  Future<void> removeToken() async {
    await prefs.remove('token');
  }

  Future<void> removeGest() async {
    await prefs.remove('gest');
  }

  Future<void> removeGuard() async {
    await prefs.remove('guard');
  }

  Future<void> removeHousId() async {
    await prefs.remove('houses_ids');
  }

  Future<void> removeOwner() async {
    await prefs.remove('Owner');
  }

  Future<void> removeName() async {
    await prefs.remove('name');
  }

  Future<void> removePhone() async {
    await prefs.remove('phone');
  }
}

Widget profileRowWidget({
  required BuildContext context,
  required String text,
  required VoidCallback onTap,
  Widget? icon,
}) {
  icon ??= Assets.svgs.arrowleft.svg();
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorName.NuturalColor2,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontDefault,
                  fontWeight: FontWeight.w400,
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    ),
  );
}
