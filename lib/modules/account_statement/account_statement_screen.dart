import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:lamassu/modules/account_statement/widget/payment_details.dart';

import '../../gen/assets.gen.dart';
import '../../models/salary_owner_model.dart';
import '../../shared/components/make_breaks.dart';
import '../../shared/components/no_internet.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'package:pie_chart/pie_chart.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AccountStatementScreen extends StatelessWidget {
  AccountStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(AppLocalizations.of(context)!.account_statement);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.account_statement,
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (BuildContext context) => PaymentsCubit()..getPayments(),
          child: BlocConsumer<PaymentsCubit, PaymentsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PaymentsGetWonerLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (context.read<PaymentsCubit>().payments != null &&
                  context.read<PaymentsCubit>().payments!.results!.isNotEmpty) {
                return buildPadding(
                    context, context.read<PaymentsCubit>().payments!);
              } else if (state is PaymentsGetWonerErrorState) {
                return Center(
                  child: noInternet(
                    context: context,
                    onTap: () {
                      context.read<PaymentsCubit>()..getPayments();
                    },
                  ),
                );
              } else
                return PlaceHolderWidget(
                  context: context,
                  title:
                      AppLocalizations.of(context)!.there_ar_payment_accounts,
                  image: Assets.illustrations.favor.svg(),
                );
            },
          ),
        ));
  }

  Widget buildPadding(
    BuildContext context,
    SalaryOwnerModel? paymentsList,
  ) {
    List<Payments> getAllPayments(SalaryOwnerModel paymentsList) {
      List<Payments> allPayments = [];
      for (var result in paymentsList.results!) {
        if (result.payments != null && result.payments!.isNotEmpty) {
          allPayments.addAll(result.payments!);
        }
      }
      return allPayments;
    }

    var allPayments = getAllPayments(paymentsList!);

    var totalPayments = paymentsList.statistics!;

    Map<String, double> dataMap = {
      "المسدد": paymentsList.statistics!.totalPayment != null
          ? paymentsList.statistics!.totalPayment!.toDouble()
          : 0.0,
      "المتبقي": paymentsList.statistics!.totalRemaining!.toDouble(),
      "الخصم": paymentsList.statistics!.totalDiscount!.toDouble(),
    };
    final colorList = <Color>[
      ColorName.successColor7,
      ColorName.errorColor6,
      ColorName.SecandaryYallw3,
    ];

    double paidPercentage = (totalPayments.totalPayment!.toDouble() /
            totalPayments.totalSalary!.toDouble()) *
        100;
    double remainingPercentage = (totalPayments.totalRemaining!.toDouble() /
            totalPayments.totalSalary!.toDouble()) *
        100;
    double discountPercentage = (totalPayments.totalDiscount!.toDouble() /
            totalPayments.totalSalary!.toDouble()) *
        100;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.code_number,
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          paymentsList.results!.first.formCode != null
                              ? "${paymentsList.results!.first.formCode.toString()}"
                              : "...",
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 0,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
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
            const SizedBox(
              height: 24,
            ),
            Container(
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
                    "${addCommasToNumber(totalPayments.totalSalary!)} ${totalPayments.isDollar ?? false ? '\$' : 'IQD'}",
                  ),
                  buildRow(
                    context,
                    AppLocalizations.of(context)!.discount,
                    ColorName.SecandaryYallw3,
                    "${addCommasToNumber(totalPayments.totalDiscount!)}  ${totalPayments.isDollar ?? false ? '\$' : 'IQD'}",
                  ),
                  buildRow(
                    context,
                    AppLocalizations.of(context)!.amounts_paid,
                    ColorName.successColor7,
                    "${addCommasToNumber(totalPayments.totalPayment!)}  ${totalPayments.isDollar ?? false ? '\$' : 'IQD'}",
                  ),
                  buildRow(
                    context,
                    AppLocalizations.of(context)!.the_remaining_amounts,
                    ColorName.errorColor6,
                    "${addCommasToNumber(totalPayments.totalRemaining!)}  ${totalPayments.isDollar ?? false ? '\$' : 'IQD'}",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: PaymentDetailsScreen(payments: allPayments),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
                      Assets.svgs.arrowleft
                          .svg(height: 20, color: ColorName.brandPrimary)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(
    BuildContext context, String title, Color color, String amount) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontDefault,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: Sizes.fontDefault,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
