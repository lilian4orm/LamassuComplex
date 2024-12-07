import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lamassu/modules/investor/models/money_houses_model.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';

class HousesMoneyWidget extends StatefulWidget {
  const HousesMoneyWidget({super.key, required this.money});

  final ReportMoneyModel money;

  @override
  State<HousesMoneyWidget> createState() => _HousesMoneyWidgetState();
}

class _HousesMoneyWidgetState extends State<HousesMoneyWidget> {
  NumberFormat number = NumberFormat.decimalPattern('en-us');

  List<Color> colorList = [
    ColorName.successColor7,
    ColorName.SecandaryYallw3,
    ColorName.errorColor5,
  ];

  late Map<String, double> dataMap;
  void initialData() {
    dataMap = {
      "المبلغ المستلم":
          double.parse(widget.money.all!.paymentAmountOwner.toString()),
      "الخصم": double.parse(widget.money.all!.discountAmountOwner.toString()),
      "المبلغ المتبقي":
          double.parse(widget.money.all!.remainingAmountOwner.toString())
    };
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: ColorName.NuturalColor5,
                        ),
                      ),
                      Text(
                        'الواردات الكلية قبل التخفيض',
                        style: const TextStyle(
                          color: ColorName.NuturalColor3,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "${number.format(widget.money.all!.salaryAmountOwner! + widget.money.all!.discountAmountOwner!)}",
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
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
        SizedBox(height: 20),
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
                        backgroundColor: ColorName.SecandaryYallw3,
                      ),
                    ),
                    Text(
                      'مبالغ التخفيضات',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.money.all!.discountAmountOwner)}",
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
                        backgroundColor: ColorName.NuturalColor5,
                      ),
                    ),
                    Text(
                      'الواردات بعد التخفيض',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.money.all!.salaryAmountOwner)}",
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontLarge,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
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
                        backgroundColor: colorList[0],
                      ),
                    ),
                    Text(
                      'المبالغ المستحصلة',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.money.all!.paymentAmountOwner)}",
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
                        backgroundColor: ColorName.errorColor5,
                      ),
                    ),
                    Text(
                      'المبالغ المتبقية',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.money.all!.remainingAmountOwner)}",
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontLarge,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
