import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../layout/navigation_bar/navigation_bar.dart';
import '../../shared/style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'login_screen.dart';

class ChooseSignIn extends StatefulWidget {
  const ChooseSignIn({super.key});

  @override
  State<ChooseSignIn> createState() => _ChooseSignInState();
}

class _ChooseSignInState extends State<ChooseSignIn> {
  bool startAnimation = false;
  bool startAnimation2 = false;
  bool startAnimation3 = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          startAnimation = true;
          Future.delayed(Duration(milliseconds: 2000), () {
            setState(() {
              startAnimation2 = true;
              Future.delayed(Duration(milliseconds: 1000), () {
                setState(() {
                  startAnimation3 = true;
                });
              });
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: size.width * .8,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: !startAnimation2 ? 0 : 1,
                    child: AnimatedScale(
                      duration: Duration(seconds: 1),
                      scale: !startAnimation2 ? .7 : 1,
                      child: Text(
                        'LAMASSU COMPLEX',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorName.bottomColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: !startAnimation3 ? 0 : 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 1,
                                color: ColorName.NuturalColor6,
                              ),
                            ),
                            Text(
                              'او يمكنك',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorName.NuturalColor6,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 1,
                                color: ColorName.NuturalColor6,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              await saveGest();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomNavBarWidget(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'الدخول كزائر',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              top: 35,
              right: !startAnimation ? size.width * 2 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width,
                  ),
                  AnimatedRotation(
                    duration: Duration(seconds: 2),
                    turns: !startAnimation ? 0 : 1,
                    child: AnimatedContainer(
                      margin: EdgeInsets.symmetric(vertical: 32),
                      duration: Duration(seconds: 1),
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('asset/lamassu.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveGest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gest', "gest");
  }
}
