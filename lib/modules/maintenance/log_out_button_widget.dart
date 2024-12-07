import 'package:flutter/material.dart';
import 'package:lamassu/gen/assets.gen.dart';
import 'package:lamassu/shared/components/logout_user.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButtonWidget extends StatefulWidget {
  const LogoutButtonWidget({
    super.key,
  });

  @override
  State<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends State<LogoutButtonWidget> {
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Assets.images.logo
                      .image(height: MediaQuery.of(context).size.height * 0.1),
                  content: Text(
                    'هل انت متاكد ؟',
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  ColorName.NuturalColor2,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'الغاء',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: ColorName.NuturalColor6,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  ColorName.NuturalColor6,
                                ),
                              ),
                              onPressed: () async {
                                logoutUser(token, context, name, phone, owner,
                                    guard, maintance, sells, housesIds);
                              },
                              child: Text(
                                'خروج',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: ColorName.secondaryLight,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              });
        },
        icon: Icon(Icons.logout_outlined));
  }
}
