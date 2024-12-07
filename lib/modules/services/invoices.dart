import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lamassu/modules/services/widget/payment_detail.dart';

import '../../gen/assets.gen.dart';
import '../../models/salary_owner_services_model.dart';
import '../../shared/components/make_breaks.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../account_statement/account_statement_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class InvoicesScreen extends StatefulWidget {
  InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>()..getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.invoices,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ServicesInvoicesGetSuccessState) {
            if (context.read<ServicesCubit>().invoices!.results != null &&
                context.read<ServicesCubit>().invoices!.results!.isNotEmpty) {
              var totalPayments =
                  context.read<ServicesCubit>().invoices!.statistics;
              return Column(
                children: [
                  sketchInvices(
                    context,
                    context.read<ServicesCubit>().invoices!,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorName.secondaryLight,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildRow(
                            context,
                            AppLocalizations.of(context)!.the_total_amount,
                            ColorName.NuturalColor5,
                            "${addCommasToNumber(totalPayments!.totalSalary!)} IQD",
                          ),
                          buildRow(
                            context,
                            AppLocalizations.of(context)!.discount,
                            ColorName.SecandaryYallw3,
                            "${addCommasToNumber(totalPayments.totalDiscount!)} IQD",
                          ),
                          buildRow(
                            context,
                            AppLocalizations.of(context)!.amounts_paid,
                            ColorName.successColor7,
                            "${addCommasToNumber(totalPayments.totalPayment!)} IQD",
                          ),
                          buildRow(
                            context,
                            AppLocalizations.of(context)!.the_remaining_amounts,
                            ColorName.errorColor6,
                            "${addCommasToNumber(totalPayments.totalRemaining!)} IQD",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: NewWidgetDetail(
                              provider:
                                  context.read<ServicesCubit>().invoices!),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.NuturalColor1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.payment_details,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor5,
                                  fontSize: Sizes.fontDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Assets.svgs.arrowleft.svg(
                                  height: 20, color: ColorName.brandPrimary)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return PlaceHolderWidget(
                context: context,
                title: "لاتوجد فواتير",
                image: Image.asset('asset/images/logo.png'),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget sketchInvices(BuildContext context, SalaryServicesModel? sketch) {
    Map<String, double> dataMap = {
      "المسدد": sketch?.statistics?.totalPayment?.toDouble() ?? 0.0,
      "المتبقي": sketch?.statistics?.totalRemaining?.toDouble() ?? 0.0,
      "الخصم": sketch?.statistics?.totalDiscount?.toDouble() ?? 0.0,
    };
    // Map<String, double> dataMap2 = {
    //   "المسدد": 50000,
    //   "المتبقي": 100000,
    // };
    // Map<String, double> dataMap3 = {
    //   "المسدد": 10000,
    //   "المتبقي": 120000,
    // };
    final colorList = <Color>[
      ColorName.successColor7,
      ColorName.errorColor6,
      ColorName.SecandaryYallw3,
    ];
    // final colorList2 = <Color>[
    //   ColorName.successColor4,
    //   ColorName.errorColor4,
    // ];
    // final colorList3 = <Color>[
    //   ColorName.brandLight,
    //   ColorName.errorColor6,
    // ];

    double paidPercentage = (sketch!.statistics!.totalPayment!.toDouble() /
            sketch.statistics!.totalSalary!.toDouble()) *
        100;
    double remainingPercentage =
        (sketch.statistics!.totalRemaining!.toDouble() /
                sketch.statistics!.totalSalary!.toDouble()) *
            100;
    double discountPercentage = (sketch.statistics!.totalDiscount!.toDouble() /
            sketch.statistics!.totalSalary!.toDouble()) *
        100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorName.secondaryLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppLocalizations.of(context)!.consumption_services,
                    style: const TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontLarge,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PieChart(
                      centerWidget: Text('الفواتير'),
                      centerTextStyle: TextStyle(
                        color: ColorName.NuturalColor1,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 0,
                      chartRadius: MediaQuery.of(context).size.width / 4,
                      initialAngleInDegree: 0,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      colorList: colorList,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.bottom,
                        showLegends: false,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                    ),
                    // PieChart(
                    //   centerWidget: Text('الكهرباء'),
                    //   centerTextStyle: TextStyle(
                    //     color: ColorName.NuturalColor5,
                    //     fontSize: Sizes.fontLarge,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   dataMap: dataMap2,
                    //   animationDuration: Duration(milliseconds: 800),
                    //   chartLegendSpacing: 0,
                    //   chartRadius: MediaQuery.of(context).size.width / 4,
                    //   initialAngleInDegree: 0,
                    //   chartType: ChartType.disc,
                    //   ringStrokeWidth: 32,
                    //   colorList: colorList2,
                    //   legendOptions: const LegendOptions(
                    //     showLegendsInRow: false,
                    //     legendPosition: LegendPosition.bottom,
                    //     showLegends: false,
                    //     legendShape: BoxShape.circle,
                    //     legendTextStyle: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   chartValuesOptions: const ChartValuesOptions(
                    //     showChartValueBackground: false,
                    //     showChartValues: false,
                    //     showChartValuesInPercentage: false,
                    //     showChartValuesOutside: false,
                    //     decimalPlaces: 1,
                    //   ),
                    // ),
                    // PieChart(
                    //   // centerText: 'الخدمات',
                    //   centerWidget: Text('الخدمات'),
                    //   dataMap: dataMap3,
                    //   animationDuration: Duration(milliseconds: 800),
                    //   chartLegendSpacing: 0,
                    //   chartRadius: MediaQuery.of(context).size.width / 4,
                    //   initialAngleInDegree: 0,
                    //   chartType: ChartType.disc,
                    //   ringStrokeWidth: 32,
                    //   colorList: colorList3,
                    //   legendOptions: const LegendOptions(
                    //     showLegendsInRow: false,
                    //     legendPosition: LegendPosition.bottom,
                    //     showLegends: false,
                    //     legendShape: BoxShape.circle,
                    //     legendTextStyle: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   chartValuesOptions: const ChartValuesOptions(
                    //     showChartValueBackground: false,
                    //     showChartValues: false,
                    //     showChartValuesInPercentage: false,
                    //     showChartValuesOutside: false,
                    //     decimalPlaces: 1,
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: ColorName.successColor7,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.amounts_paid,
                              style: const TextStyle(
                                color: ColorName.NuturalColor3,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${paidPercentage.toInt()}%",
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: ColorName.errorColor6,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .the_remaining_amounts,
                              style: const TextStyle(
                                color: ColorName.NuturalColor3,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${remainingPercentage.toInt()}%",
                          style: TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: ColorName.SecandaryYallw3,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.discount,
                              style: const TextStyle(
                                color: ColorName.SecandaryYallw3,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${discountPercentage.toInt()}%",
                          style: TextStyle(
                            color: ColorName.SecandaryYallw3,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
