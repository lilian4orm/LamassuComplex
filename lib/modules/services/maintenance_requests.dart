import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/modules/services/request_services/request_service.dart';
import 'package:lamassu/modules/services/widget/dialog_services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/assets.gen.dart';
import '../../models/services_model.dart';
import '../../shared/end_point/end_point.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class MaintenanceRequestsScreen extends StatefulWidget {
  const MaintenanceRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceRequestsScreen> createState() =>
      _MaintenanceRequestsScreenState();
}

class _MaintenanceRequestsScreenState extends State<MaintenanceRequestsScreen> {
  int? selectedIndex;
  late SharedPreferences prefs;
  String? Id;
  String? name;
  String? phone;
  TextEditingController note = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isDeviceSupported = false;
  bool startAnimation = false;

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            startAnimation = true;
          });
        });
      });
      name = prefs.getString('name');
      phone = prefs.getString('phone');
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>()..getServices("صيانة");

    initSharedPreferences();
    _checkBiometrics();
    _checkDeviceSupport();
  }

  Future<void> _checkBiometrics() async {
    try {
      _canCheckBiometrics = await auth.canCheckBiometrics;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkDeviceSupport() async {
    try {
      _isDeviceSupported = await auth.isDeviceSupported();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _authenticateAndProceed(BuildContext context) async {
    bool authenticated = false;

    if (_canCheckBiometrics || _isDeviceSupported) {
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'يرجى المصادقة لإكمال الطلب',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } catch (e) {
        print(e);
      }
    }

    ServicesCubit servicesCubit = context.read<ServicesCubit>();
    servicesCubit.postReservationsService(
        name.toString(), phone.toString(), Id.toString(), note.text);
    Navigator.of(context).pop();

    if (!authenticated && (_canCheckBiometrics || _isDeviceSupported)) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("خطا في التحقق"),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.maintenance_requests,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) async {
          if (state is ServicesReservationsGetSuccessState) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return servicesDialog(
                    note: note,
                    context: context,
                    bottom: false,
                    title: AppLocalizations.of(context)!
                        .the_request_was_completed_successfully,
                    subtitle: AppLocalizations.of(context)!
                        .the_maintenance_team_would_like_to_inform_you_that,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    titleBottom:
                        AppLocalizations.of(context)!.continue_browsing,
                  );
                });
            context.read<ServicesCubit>().getServices("صيانة");
          } else if (state is ServicesReservationsGetLoadingState) {
            Center(child: CircularProgressIndicator());

            context.read<ServicesCubit>().getServices("صيانة");
          } else if (state is ServicesReservationsGetErrorState) {
            context.read<ServicesCubit>().getServices("صيانة");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطا في الحجز"),
                backgroundColor: Colors.red,
              ),
            );
          } else
            Center(child: CircularProgressIndicator());
        },
        builder: (context, state) {
          if (state is ServicesGetSuccessState) {
            var hieght = MediaQuery.of(context).size.height;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .please_specify_the_type_of_maintenance_you_require,
                    style: const TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontDefault,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: context.read<ServicesCubit>().services!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300 * index),
                          curve: Curves.easeInOut,
                          transform: Matrix4.translationValues(
                              0, startAnimation ? 0 : hieght, 0),
                          child: maintenanceCard(
                              context: context,
                              maintenance: context
                                  .read<ServicesCubit>()
                                  .services![index],
                              onTap: () {},
                              index: index),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Id != null) {
                        // showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return servicesDialog(
                        //       note: note,
                        //       context: context,
                        //       bottom: true,
                        //       title: AppLocalizations.of(context)!.confirmation,
                        //       subtitle: AppLocalizations.of(context)!
                        //           .thank_you_for_requesting_the_service_we_are_happy,
                        //       onTap: () {
                        //         _authenticateAndProceed(context);
                        //       },
                        //       titleBottom:
                        //           AppLocalizations.of(context)!.confirmation,
                        //     );
                        //   },
                        // );
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ServiceRequestScreen(
                            service: context
                                .read<ServicesCubit>()
                                .services!
                                .where((element) => element.sId == Id)
                                .first,
                          );
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("يرجى اختيار الخدمة"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: state is ServicesReservationsGetLoadingState
                        ? CircularProgressIndicator()
                        : Text(
                            Id != null
                                ? 'التالي'
                                : AppLocalizations.of(context)!.choose_service,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: ColorName.secondaryLight,
                                ),
                          ),
                  ),
                ],
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget maintenanceCard(
      {required BuildContext context,
      required ServicesResults maintenance,
      required VoidCallback onTap,
      required int index}) {
    return GestureDetector(
      onTap: () {
        if (selectedIndex == index) {
          selectedIndex = null;
          Id = null;
        } else {
          selectedIndex = index;
          Id = maintenance.sId;
        }
        // selectedIndex = index;
        // Id = maintenance.sId;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(0),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: (selectedIndex == index)
              ? ColorName.SecandaryYallw2
              : ColorName.secondaryLight,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 2),
              blurRadius: 2,
              color: Colors.grey,
            )
          ],
          // border: Border.all(color: ColorName.NuturalColor5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // alignment: Alignment.center,
          children: [
            // Blurred Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: CachedNetworkImage(
                      imageUrl: imageStorg + "${maintenance.image}",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Assets.images.logo.image(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            // Overlay Text
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${maintenance.name}",
                  maxLines: 1,
                  style: const TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontDefault,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
