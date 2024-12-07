import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lamassu/modules/investor/models/service_model.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';

class ServiceChart extends StatefulWidget {
  const ServiceChart({
    super.key,
    required this.title,
    required this.isAll,
    required this.service,
  });

  final String title;
  final bool isAll;
  final ReportServiceModel service;

  @override
  State<ServiceChart> createState() => _ServiceChartState();
}

class _ServiceChartState extends State<ServiceChart> {
  NumberFormat number = NumberFormat.decimalPattern('en-us');
  Map<String, double> dataMap = {};
  List<Color> colorList = [
    ColorName.successColor7,
    ColorName.errorColor5,
  ];
  @override
  void initState() {
    if (widget.isAll == true) {
      dataMap = {
        'المدفوع': double.parse(widget.service.all!.paymentAmount.toString()),
        'لم يتم الدفع': double.parse(widget.service.all!.remaining.toString()),
      };
    } else {
      dataMap = {
        'المدفوع': double.parse(widget.service.today!.paymentAmount.toString()),
        'لم يتم الدفع':
            double.parse(widget.service.today!.remaining.toString()),
      };
    }
    super.initState();
  }

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
                  widget.title,
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
                        'المبلغ الكلي',
                        style: const TextStyle(
                          color: ColorName.NuturalColor3,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  if (widget.isAll)
                    Text(
                      "${number.format(widget.service.all!.salaryAmount)}",
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (!widget.isAll)
                    Text(
                      "${number.format(widget.service.today!.salaryAmount)}",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
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
                          backgroundColor: colorList[0],
                        ),
                      ),
                      Text(
                        'المبلغ المستحصل',
                        style: const TextStyle(
                          color: ColorName.NuturalColor3,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  if (widget.isAll)
                    Text(
                      "${number.format(widget.service.all!.paymentAmount)}",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (!widget.isAll)
                    Text(
                      "${number.format(widget.service.today!.paymentAmount)}",
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
                        'المبلغ المتبقي',
                        style: const TextStyle(
                          color: ColorName.NuturalColor3,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  if (widget.isAll)
                    Text(
                      "${number.format(widget.service.all!.remaining)}",
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (!widget.isAll)
                    Text(
                      "${number.format(widget.service.today!.remaining)}",
                      style: const TextStyle(
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
      ),
    );
  }
}
