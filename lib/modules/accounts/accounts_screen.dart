import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/accounts/cubit/cubit.dart';
import 'package:lamassu/modules/accounts/cubit/state.dart';
import 'package:lamassu/modules/auth/login_screen.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  String? email;
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الحسابات',
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.add))
        ],
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AccountsCubit()..getAccounts(),
        child: BlocConsumer<AccountsCubit, AccountStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AccountGetAccountSuccessState) {
                final cubit = AccountsCubit.get(context);
                return ListView.builder(
                  itemCount: cubit.accounts!.length,
                  itemBuilder: (context, index) {
                    final account = cubit.accounts![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: email == account.email
                            ? null
                            : () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.clear();
                                pref.setString('email', account.email!);
                                pref.setString('name', account.name!);
                                pref.setString('phone', account.phone!);
                                pref.setString('token', account.token!);
                                pref.setString(account.type!, account.type!);
                                bool isIOS = Theme.of(context).platform ==
                                    TargetPlatform.iOS;
                                if (!isIOS) {
                                  Restart.restartApp();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'تأكيد',
                                          style: TextStyle(
                                            color: ColorName.NuturalColor5,
                                            fontSize: Sizes.fontLarge,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        content: const Text(
                                          'لتحميل البيانات سيتم الخروج من التطبيق. انقر على التاكيد للمتابعة.',
                                        ),
                                        actions: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(
                                                ColorName.NuturalColor6,
                                              ),
                                            ),
                                            onPressed: () {
                                              Restart.restartApp();
                                            },
                                            child: Text(
                                              'تأكيد',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color:
                                                        ColorName.NuturalColor1,
                                                  ),
                                            ),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(
                                                ColorName.NuturalColor2,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'إلغاء',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color:
                                                        ColorName.NuturalColor6,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: ColorName.NuturalColor2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              account.email ?? 'email',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontDefault,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              account.name ?? 'name',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                email == account.email
                                    ? SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          cubit.deleteAccount(account.email!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: ColorName.errorColor5,
                                        ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is AccountGetAccountErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontLarge,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
