import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lamassu/modules/investor/models/hoses_report_model.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';

class ChartInfoWidget extends StatelessWidget {
  const ChartInfoWidget({
    super.key,
    required this.dataMap,
    required this.colorList,
    required this.house,
    required this.title,
    required this.title1,
    required this.title2,
    required this.isAll,
    required this.title3,
    this.total = 0,
  });
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final ReportHouseModel house;
  final String title, title1, title2, title3;
  final bool isAll;
  final double? total;
  static NumberFormat numberFormat = NumberFormat.decimalPattern('en-US');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style:
                      TextStyle(fontSize: 16, color: ColorName.NuturalColor3),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
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
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title3,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor3,
                                  fontSize: Sizes.fontSmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isAll)
                        Text(
                          "${house.numberOfHouses}",
                          style: TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (!isAll)
                        Text(
                          "${numberFormat.format(total)}",
                          style: TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
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
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title1,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor3,
                                  fontSize: Sizes.fontSmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isAll)
                        Text(
                          "${house.numberOfSoldHouses}",
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (!isAll)
                        Text(
                          "${house.numberOfReceivedHouses}",
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
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
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title2,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor3,
                                  fontSize: Sizes.fontSmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isAll)
                        Text(
                          "${int.parse(house.numberOfHouses.toString()) - int.parse(house.numberOfSoldHouses.toString())}",
                          style: TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (!isAll)
                        Text(
                          "${int.parse(house.numberOfSoldHouses.toString()) - int.parse(house.numberOfReceivedHouses.toString())}",
                          style: TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
