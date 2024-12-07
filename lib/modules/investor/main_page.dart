import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamassu/gen/assets.gen.dart';
import 'package:lamassu/modules/accounts/accounts_screen.dart';
import 'package:lamassu/modules/auth/login_screen.dart';
import 'package:lamassu/modules/home/cubit/cubit.dart';
import 'package:lamassu/modules/home/cubit/state.dart';
import 'package:lamassu/modules/home/widget/home_body.dart';
import 'package:lamassu/modules/investor/houses/houses_screen.dart';
import 'package:lamassu/modules/investor/money_houses/money_houses_screen.dart';
import 'package:lamassu/modules/investor/security_clean/security_clean_screen.dart';
import 'package:lamassu/modules/investor/service/service_screen.dart';
import 'package:lamassu/modules/investor/service_request/service_request_screen.dart';
import 'package:lamassu/shared/components/local_database/sql_database.dart';
import 'package:lamassu/shared/remote/dio_helper.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvestorMainPage extends StatefulWidget {
  const InvestorMainPage({super.key});

  @override
  State<InvestorMainPage> createState() => _InvestorMainPageState();
}

class _InvestorMainPageState extends State<InvestorMainPage> {
  bool startAnimation = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            startAnimation = true;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقارير مجمع الروان'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AccountsScreen()));
              },
              icon: Icon(Icons.add_circle_outline_sharp)),
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return logoutAlertDialog(context, true);
                  },
                );
              },
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  if (context.read<HomeCubit>().lastNews != null)
                    buildCarousel(),
                  Row(
                    children: [
                      buttonWidget(context, 'مبيعات الوحدات السكنية',
                          'asset/svgs/counting-svgrepo-com.svg', 1, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HouseReportScreen()));
                      }),
                      buttonWidget(context, 'فواتير الوحدات السكنية',
                          'asset/svgs/bill-list-svgrepo-com.svg', 2, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MoneyHousesScreen()));
                      }),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      buttonWidget(context, 'فواتير الخدمات الشهرية',
                          'asset/svgs/security-camera-svgrepo-com.svg', 3, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SecurityCleanScreen()));
                      }),
                      buttonWidget(
                          context,
                          'فواتير خدمات ما بعد البيع',
                          'asset/svgs/service-crew-member-svgrepo-com.svg',
                          4, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ServiceScreen()));
                      }),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonWidget(context, 'طلبات حجوزات الخدمات',
                          'asset/svgs/request-approval-svgrepo-com.svg', 5, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ServiceRequestReportScreen()));
                      }),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget buttonWidget(BuildContext context, String text, String img, int index,
      void Function()? onTap) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: index * 500),
          curve: Curves.easeInOutBack,
          transform:
              Matrix4.translationValues(0, startAnimation ? 0 : size.height, 0),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorName.NuturalColor1,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: .5,
                          color: ColorName.NuturalColor3.withOpacity(.5),
                        )
                      ]),
                  child: Center(
                    child: SvgPicture.asset(
                      img,
                      width: 50,
                      height: 50,
                    ),
                  )),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    String? email = pref.getString('email');
    String? token = pref.getString('token');
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
        pref.clear();
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

  Widget logoutAlertDialog(BuildContext context, bool bottom) {
    return AlertDialog(
      title: Assets.images.logo.image(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      content: Text(
        AppLocalizations.of(context)!.do_you_really_want_to_log_out,
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
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                });
            logout(context);
          },
          child: Text(
            AppLocalizations.of(context)!.log_out,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorName.secondaryLight,
                ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
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
