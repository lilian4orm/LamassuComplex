import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gen/assets.gen.dart';
import '../modules/about_complex/about_complex.dart';
import '../modules/account_statement/account_statement_screen.dart';
import '../modules/favorite/favorite_screen.dart';
import '../modules/form/form_sells_employee.dart';
import '../modules/home/home_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/search/search_screen.dart';
import '../shared/style/colors.dart';

class ResidentialLayout extends StatefulWidget {
  ResidentialLayout({Key? key}) : super(key: key);

  @override
  _ResidentialLayoutState createState() => _ResidentialLayoutState();
}

class _ResidentialLayoutState extends State<ResidentialLayout> {
  late PersistentTabController _controller;
  String? token;
  String? sells;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      sells = prefs.getString('sells_emp');
    });
  }

  List<Widget> _buildScreens() {
    print(token);
    return [
      HomeScreen(),
      SearchScreen(),
      token != null
          ? sells == null
              ? AccountStatementScreen()
              : FormSelleEmployee()
          : AboutTheComplex(),
      FavoriteScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          onPressed: (context) {
            _controller.index = 0;
            setState(() {});
          },
          icon: _controller.index == 0
              ? Assets.svgs.home2.svg()
              : Assets.svgs.home.svg(),
        ),
        PersistentBottomNavBarItem(
          onPressed: (context) {
            _controller.index = 1;
            setState(() {});
          },
          icon: _controller.index == 1
              ? Assets.svgs.minimalisticMagnifer2.svg()
              : Assets.svgs.minimalisticMagnifer.svg(),
        ),
        PersistentBottomNavBarItem(
            onPressed: (context) {
              _controller.index = 2;
              setState(() {});
            },
            opacity: 1,
            icon: token != null
                ? sells == null
                    ? Assets.svgs.property35
                        .svg(color: ColorName.secondaryLight, height: 25)
                    : Assets.svgs.addition
                        .svg(color: ColorName.secondaryLight, height: 25)
                : Assets.svgs.buildings
                    .svg(color: ColorName.secondaryLight, height: 25),
            activeColorSecondary: ColorName.brandPrimary,
            activeColorPrimary: ColorName.brandPrimary),
        PersistentBottomNavBarItem(
          onPressed: (context) {
            _controller.index = 3;
            setState(() {});
          },
          icon: _controller.index == 3
              ? Assets.svgs.userRounded2.svg()
              : Assets.svgs.userRounded2.svg(),
        ),
        PersistentBottomNavBarItem(
          onPressed: (context) {
            _controller.index = 4;
            setState(() {});
          },
          icon: _controller.index == 4
              ? Assets.svgs.userRounded2.svg()
              : Assets.svgs.userRounded.svg(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: ColorName.secondaryLight,
        decoration: const NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorName.NuturalColor2,
              spreadRadius: 0.3,
              blurRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
