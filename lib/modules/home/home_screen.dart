import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:lamassu/modules/home/widget/electric/electric_usage.dart';
import 'package:lamassu/modules/home/widget/home_body.dart';
import 'package:lamassu/modules/monthly_bills/monthly_bills_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gen/assets.gen.dart';
import '../../shared/components/Shimmer_home_screen.dart';
import '../../shared/components/no_internet.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../notifications/notifications_screen.dart';
import '../services/invoices.dart';
import '../services/maintenance_requests.dart';
import '../services/share_qr.dart';
import '../services/shipping_services.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  String? name;
  String? sells;

  @override
  void initState() {
    // followTopics();
    super.initState();

    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      sells = prefs.getString('sells_emp');
      name = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LAMASSU COMPLEX",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ColorName.bottomColor,
            fontSize: Sizes.fontLarge,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 50,
            child: TextButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: NotificationsScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Assets.svgs.bell.svg(color: ColorName.bottomColor),
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Widget content;

          if (state is HomeGetAdsErrorState ||
              state is HomeGetAdvantagesErrorState ||
              state is HomeGetHousesErrorState) {
            if (state is HomeGetAdsErrorState &&
                state is HomeGetAdvantagesErrorState &&
                state is HomeGetHousesErrorState) {
              content = Center(
                child: PlaceHolderWidget(
                  context: context,
                  title: 'حدث خطأ',
                  image: Assets.illustrations.house.svg(),
                ),
              );
            } else {
              content = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 6),
                  noInternet(
                    context: context,
                    onTap: () {
                      context.read<HomeCubit>().getLastNews();
                      context.read<HomeCubit>().getAdvantages();
                      context.read<HomeCubit>().getHouses("", '');
                      context.read<HomeCubit>().getHouses("", 'بيع');
                      context.read<HomeCubit>().getHouses("", 'ايجار');
                    },
                  ),
                ],
              );
            }
          } else if (state is HomeGetAdvantagesLoadingState ||
              state is HomeGetHousesLoadingState ||
              state is HomeGetAdsLoadingState) {
            content = ShimmerWidget(context);
          } else {
            content = SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (context.read<HomeCubit>().lastNews != null)
                    buildCarousel(),
                  if (context.read<HomeCubit>().advantages != null)
                    sells == null && token != null
                        ? bulidCardServices()
                        : buildFeaturesSection(context),
                  if (context.read<HomeCubit>().houses2 != null)
                    buildSaleOffersSection(context, true),
                  if (context.read<HomeCubit>().houses3 != null)
                    buildRentalOffersSection(context, true),
                ],
              ),
            );
          }

          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              context.read<HomeCubit>().getLastNews();
              context.read<HomeCubit>().getAdvantages();
              context.read<HomeCubit>().getHouses("", '');
              context.read<HomeCubit>().getHouses("", 'بيع');
              context.read<HomeCubit>().getHouses("", 'ايجار');
            },
            child: content,
          );
        },
      ),
    );
  }

  Widget bulidCardServices() {
    final houses = context.read<HomeCubit>().advantages;

    if (houses == null || houses.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.services,
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Row(
                children: [
                  cardServices(
                      context: context,
                      text: AppLocalizations.of(context)!.maintenance_requests,
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MaintenanceRequestsScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      icon: Assets.svgs.shockAbsorber.svg(
                          width: 35, height: 35, color: ColorName.bottomColor)),
                  cardServices(
                      context: context,
                      text: AppLocalizations.of(context)!.shipping_services,
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ShippingScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      icon: Assets.svgs.translation.svg(
                          width: 35, height: 35, color: ColorName.bottomColor)),
                  // cardServices(
                  //     context: context,
                  //     text: AppLocalizations.of(context)!.invoices,
                  //     onTap: () {
                  //       PersistentNavBarNavigator.pushNewScreen(
                  //         context,
                  //         screen: InvoicesScreen(),
                  //         withNavBar: false,
                  //         pageTransitionAnimation: PageTransitionAnimation.fade,
                  //       );
                  //     },
                  //     icon: Assets.svgs.ticket.svg(
                  //         width: 35,
                  //         height: 35,
                  //         color: ColorName.brandSecondary)),
                  cardServices(
                      context: context,
                      text: AppLocalizations.of(context)!.share_qr,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return shareQrAlertDialog(context, name!);
                          },
                        );
                      },
                      icon: Assets.svgs.codeScan.svg(
                          width: 35, height: 35, color: ColorName.bottomColor)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cardServices(
                      context: context,
                      text: 'استهلاك الكهرباء',
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ElectricUsageScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      icon: SvgPicture.asset(
                        'asset/svgs/meter.svg',
                        width: 35,
                        height: 35,
                        color: ColorName.bottomColor,
                      )),
                  cardServices(
                      context: context,
                      text: 'الفواتير الشهرية',
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MonthlyBillsScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      icon: SvgPicture.asset(
                        'asset/svgs/bills_mon.svg',
                        color: ColorName.bottomColor,
                        width: 45,
                        height: 45,
                      )),
                  cardServices(
                      context: context,
                      text: AppLocalizations.of(context)!.invoices,
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: InvoicesScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      icon: Assets.svgs.ticket.svg(
                          width: 35, height: 35, color: ColorName.bottomColor)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget cardServices({
    required BuildContext context,
    required String text,
    required VoidCallback onTap,
    required Widget? icon,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                  radius: 35,
                  backgroundColor: ColorName.NuturalColor1,
                  child: icon),
            ),
            SizedBox(
              height: 8,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: const TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
