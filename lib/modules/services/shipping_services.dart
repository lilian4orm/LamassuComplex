import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/modules/services/request_shipping.dart';
import 'package:lamassu/modules/services/widget/dialog_services.dart';
import 'package:lamassu/shared/components/make_breaks.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/assets.gen.dart';
import '../../models/services_model.dart';
import '../../shared/end_point/end_point.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  int? selectedIndex;
  late SharedPreferences prefs;
  String? Id;
  String? name;
  String? phone;
  TextEditingController note = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isDeviceSupported = false;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      phone = prefs.getString('phone');
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>()..getServices("شحن");
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
          AppLocalizations.of(context)!.shipping_services,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) {
          if (state is ServicesReservationsGetSuccessState) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return servicesDialog(
                    note: note,
                    context: context,
                    bottom: false,
                    title: AppLocalizations.of(context)!
                        .shipping_has_been_confirmed_successfully,
                    subtitle: AppLocalizations.of(context)!
                        .thank_you_for_choosing_us_for_your_needs,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    titleBottom:
                        AppLocalizations.of(context)!.continue_browsing,
                  );
                });
            context.read<ServicesCubit>().getServices("شحن");
          } else if (state is ServicesReservationsGetLoadingState) {
            Center(child: CircularProgressIndicator());
            context.read<ServicesCubit>().getServices("شحن");
          } else if (state is ServicesReservationsGetErrorState) {
            context.read<ServicesCubit>().getServices("شحن");
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
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .we_are_pleased_to_serve_you_in_the,
                    style: const TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontDefault,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount:
                          context.read<ServicesCubit>().services2!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ShippingCard(
                            context: context,
                            maintenance:
                                context.read<ServicesCubit>().services2![index],
                            onTap: () {},
                            index: index);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Id != null)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RequestShippingScreen(
                              note: note,
                              onTap: () {
                                _authenticateAndProceed(context);
                              },
                            ),
                          ),
                        );
                    },
                    child: state is ServicesReservationsGetLoadingState
                        ? CircularProgressIndicator()
                        : Text(
                            Id != null
                                ? AppLocalizations.of(context)!.confirmation
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

  Widget ShippingCard(
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
        setState(() {});
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        color: (selectedIndex == index)
            ? ColorName.SecandaryYallw2
            : ColorName.secondaryLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: CachedNetworkImage(
                      imageUrl: imageStorg + "${maintenance.image}",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      width: MediaQuery.of(context).size.width,
                      errorWidget: (context, url, error) =>
                          Assets.images.logo.image(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${maintenance.name}",
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          style: const TextStyle(
                            color: ColorName.NuturalColor6,
                            fontSize: Sizes.fontDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${addCommasToNumber(maintenance.price!)} IQD",
                    style: const TextStyle(
                      color: ColorName.successColor7,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w400,
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
}
