import 'package:lamassu/layout/navigation_bar/widgets/botton_navigation_bar_item.dart';
import 'package:lamassu/modules/favorite/favorite_screen.dart';
import 'package:lamassu/modules/home/home_screen.dart';
import 'package:lamassu/modules/offers/sales_offers.dart';

import 'package:lamassu/modules/search/search_screen.dart';
import 'package:lamassu/modules/services/invoices.dart';
import 'package:flutter/material.dart';
import 'package:lamassu/shared/end_point/end_point.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../gen/assets.gen.dart';
import '../../modules/about_complex/about_complex.dart';
import '../../modules/account_statement/account_statement_screen.dart';
import '../../modules/form/form_sells_employee.dart';
import '../../modules/profile/profile_screen.dart';

class CustomNavBarWidget extends StatefulWidget {
  const CustomNavBarWidget({super.key});

  @override
  State<CustomNavBarWidget> createState() => _CustomNavBarWidgetState();
}

class _CustomNavBarWidgetState extends State<CustomNavBarWidget> {
  int selectedIndex = 0;
  String? token;
  String? sells;
  String? owner;
  String? rent;

  late List<Widget> pages;
  bool isLoading = true; // Add a loading state
  late SharedPreferences prefs;

  @override
  void initState() {
    followTopics();
    super.initState();

    _loadToken().then((_) {
      setState(() {
        pages = [
          HomeScreen(),
          owner == null ? SearchScreen() : InvoicesScreen(),
          token != null
              ? (sells != null
                  ? FormSelleEmployee()
                  : rent != null
                      ? AboutTheComplex()
                      : AccountStatementScreen())
              : AboutTheComplex(),
          owner == null ? FavoriteScreen() : SalesOffersScreen(title: 'بيع'),
          ProfileScreen(),
        ];
        isLoading = false;
      });
    });
  }

  Future<void> _loadToken() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      sells = prefs.getString('sells_emp');
      owner = prefs.getString('owner');
      rent = prefs.getString('rent');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: pages[selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: ColorName.bottomColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(4, 4))
                  ]),
              height: MediaQuery.of(context).size.height * .08,
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonNavBarItem(
                      SelectedIndex: selectedIndex,
                      index: 0,
                      svgIconPath: Assets.svgs.home2.path,
                      svgSelectedIconPath: Assets.svgs.home.path,
                      title: 'الصفحة الرئيسية',
                      onTap: () {
                        selectedIndex = 0;
                        setState(() {});
                      },
                    ),
                    ButtonNavBarItem(
                      SelectedIndex: selectedIndex,
                      onTap: () {
                        selectedIndex = 1;
                        setState(() {});
                      },
                      index: 1,
                      svgIconPath: owner == null
                          ? Assets.svgs.minimalisticMagnifer2.path
                          : 'asset/svgs/dollar-fill.svg',
                      svgSelectedIconPath: owner == null
                          ? Assets.svgs.minimalisticMagnifer.path
                          : 'asset/svgs/dollar-out.svg',
                      title: 'فواتير الخدمات',
                    ),
                    ButtonNavBarItem(
                      SelectedIndex: selectedIndex,
                      onTap: () {
                        selectedIndex = 2;
                        setState(() {});
                      },
                      index: 2,
                      svgIconPath: token != null
                          ? sells != null
                              ? Assets.svgs.property35.path
                              : Assets.svgs.canternav.path
                          : 'asset/svgs/building-svgrepo-com.svg',
                      svgSelectedIconPath: token != null
                          ? sells != null
                              ? Assets.svgs.property35.path
                              : Assets.svgs.canternav.path
                          : 'asset/svgs/building-svgrepo-com.svg',
                      title: '',
                    ),
                    ButtonNavBarItem(
                      SelectedIndex: selectedIndex,
                      onTap: () {
                        selectedIndex = 3;
                        setState(() {});
                      },
                      index: 3,
                      svgIconPath: owner == null
                          ? Assets.svgs.like1.path
                          : Assets.svgs.buildings.path,
                      svgSelectedIconPath: owner == null
                          ? Assets.svgs.like2.path
                          : Assets.svgs.buildings.path,
                      title: 'الزوار',
                    ),
                    ButtonNavBarItem(
                      SelectedIndex: selectedIndex,
                      onTap: () {
                        selectedIndex = 4;
                        setState(() {});
                      },
                      index: 4,
                      svgIconPath: Assets.svgs.userRounded2.path,
                      svgSelectedIconPath: Assets.svgs.userRounded.path,
                      title: 'الحساب الشخصي',
                    ),
                  ],
                ),
              ),
            )
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            //   floatingActionButton: InkWell(
            //     onTap: () {
            //       selectedIndex = 2;
            //       print(selectedIndex);
            //       setState(() {});
            //     },
            //     child: SizedBox(
            //       height: MediaQuery.of(context).size.height * .13,
            //       width: MediaQuery.of(context).size.width / 5,
            //       child: Stack(
            //         alignment: Alignment.center,
            //         children: [
            //           Assets.svgs.canternav.svg(),
            // token != null
            //     ? sells == null
            //         ? Assets.svgs.property35.svg(
            //             color: ColorName.secondaryLight, height: 35)
            //         : Assets.svgs.addition.svg(
            //             color: ColorName.secondaryLight, height: 35)
            //     : Assets.svgs.logo
            //         .svg(color: ColorName.secondaryLight, height: 40),
            //         ],
            //       ),
            //     ),
            //   ),
            );
  }
}
