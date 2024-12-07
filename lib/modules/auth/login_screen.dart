import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/accounts/accounts_screen.dart';
import 'package:lamassu/modules/auth/cubit/state.dart';
import 'package:lamassu/modules/investor/main_page.dart';
import 'package:lamassu/modules/maintenance/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/assets.gen.dart';
import '../../layout/navigation_bar/navigation_bar.dart';
import '../../shared/components/custom_textformfield.dart';
import '../../shared/components/loading.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../security_guards/home_qr_code.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginGetLoginLoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return loadingDialog();
              },
            );
          } else if (state is LoginGetLoginSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("تم التسجيل بنجاح"),
                backgroundColor: Colors.green,
              ),
            );
            if (LoginCubit.get(context).User!.results.type == "guard") {
              await saveGuard();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeGuardsScreen()),
                (Route<dynamic> route) => false,
              );
            }
            if (LoginCubit.get(context).User!.results.type ==
                "maintenance_emp") {
              await saveMaintenace();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MaintanceHome()),
                (Route<dynamic> route) => false,
              );
            } else if (LoginCubit.get(context).User!.results.type == "owner") {
              await saveOwner();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CustomNavBarWidget()),
                (Route<dynamic> route) => false,
              );
            } else if (LoginCubit.get(context).User!.results.type ==
                "investor") {
              await saveInvestor();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InvestorMainPage()),
                (Route<dynamic> route) => false,
              );
            } else if (LoginCubit.get(context).User!.results.type == "tenant") {
              await saveRent();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CustomNavBarWidget()),
                (Route<dynamic> route) => false,
              );
            } else if (LoginCubit.get(context).User!.results.type ==
                "sells_emp") {
              await saveSells();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CustomNavBarWidget()),
                (Route<dynamic> route) => false,
              );
            }
          } else if (state is LoginGetLoginErrorState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطا في تسجيل الدخول"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'asset/lamassu.png',
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'LAMASSU COMLEX',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: ColorName.bottomColor,
                                  fontSize: Sizes.fontExtraLarge,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .discover_unique_lifestyle,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor4,
                                  fontSize: Sizes.fontSmall,
                                ),
                                textAlign: TextAlign.right,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CustomTextFormField(
                                keyboardType: TextInputType.text,
                                margin: const EdgeInsets.only(
                                  top: Sizes.space32,
                                  bottom: Sizes.space12,
                                ),
                                controller: phoneNumberController,
                                hintText: AppLocalizations.of(context)!
                                    .email_optional,
                                svgPath: Assets.svgs.userRounded.path,
                                validator: (value) =>
                                    Validator.validatePhoneNumber(
                                        value, state)),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              svgPath: Assets.svgs.keySvgrepoCom.path,
                              validator: (value) =>
                                  Validator.validatePassword(value, state),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  LoginCubit.get(context).loginUser(
                                    phoneNumberController.text,
                                    passwordController.text,
                                  );
                                  if (state is LoginGetLoginSuccessState) {}
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: ColorName.secondaryLight,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      await saveGest();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomNavBarWidget(),
                                        ),
                                      );
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .you_can_enter_as_guest,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ColorName.brandPrimary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  ColorName.brandPrimary,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    // style: ElevatedButton.styleFrom(
                                    //   backgroundColor:
                                    //       ColorName.SecandaryYallw3,
                                    // ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountsScreen()));
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'الحسابات',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ColorName.NuturalColor1,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> saveGest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await prefs.setString('gest', "gest");
  }

  Future<void> saveGuard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('guard', "guard");
    print("Saved guard: ${prefs.getString('guard')}");
  }

  Future<void> saveMaintenace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('maintenance', "maintenance");
    print("Saved maintenance: ${prefs.getString('maintenance')}");
  }

  Future<void> saveOwner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('owner', "owner");
  }

  Future<void> saveInvestor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('investor', "investor");
  }

  Future<void> saveSells() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sells_emp', "sells_emp");
  }

  Future<void> saveRent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rent', "rent");
  }
}

class Validator {
  static String? validatePhoneNumber(String? value, LoginStates? state) {
    if (state is LoginGetLoginErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال اسم مستخدم";
      }
      return null;
    }

    return null;
  }

  static String? validatePassword(String? value, LoginStates? state) {
    if (state is LoginGetLoginErrorState) {
      if (value == null || value.isEmpty) {
        return "يتطلب ادخل رمز الدخول";
      }
      return null;
    }

    return null;
  }
}
