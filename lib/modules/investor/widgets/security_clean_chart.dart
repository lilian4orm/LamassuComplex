import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lamassu/modules/investor/models/security_clean_model.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';

class SecurityCleanChart extends StatefulWidget {
  const SecurityCleanChart({super.key, required this.security});

  final ReportSecurityCleanModel security;

  @override
  State<SecurityCleanChart> createState() => _SecurityCleanChartState();
}

class _SecurityCleanChartState extends State<SecurityCleanChart> {
  NumberFormat number = NumberFormat.decimalPattern('en-us');

  List<Color> colorList = [
    ColorName.successColor7,
    ColorName.errorColor5,
  ];

  late Map<String, double> dataMap;
  void initialData() {
    dataMap = {
      "المستلمة": double.parse(widget.security.isPaid!.totalPrice.toString()),
      "المتبقية": double.parse(widget.security.notPaid!.totalPrice.toString()),
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
          padding: const EdgeInsets.only(right: 30, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        'المبالغ الكلية',
                        style: const TextStyle(
                          color: ColorName.NuturalColor3,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "${number.format(widget.security.isPaid!.totalPrice! + widget.security.notPaid!.totalPrice!)}",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: ColorName.NuturalColor5,
                          ),
                        ),
                        Text(
                          'عدد الفواتير الكلي',
                          style: const TextStyle(
                            color: ColorName.NuturalColor3,
                            fontSize: Sizes.fontSmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "${number.format(widget.security.isPaid!.count! + widget.security.notPaid!.count!)}",
                      style: const TextStyle(
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
                  "${number.format(widget.security.isPaid!.totalPrice)}",
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
                        backgroundColor: colorList[1],
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
                  "${number.format(widget.security.notPaid!.totalPrice)}",
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
                      'عدد الفواتير المستحصلة',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.security.isPaid!.count)}",
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
                        backgroundColor: colorList[1],
                      ),
                    ),
                    Text(
                      'عدد الفواتير المتبقية',
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${number.format(widget.security.notPaid!.count)}",
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
