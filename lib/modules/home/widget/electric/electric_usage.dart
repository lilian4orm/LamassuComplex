import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lamassu/models/electric_model.dart';
import 'package:lamassu/modules/home/widget/electric/cubit/cubit.dart';
import 'package:lamassu/modules/home/widget/electric/cubit/state.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class ElectricUsageScreen extends StatefulWidget {
  const ElectricUsageScreen({super.key});

  @override
  State<ElectricUsageScreen> createState() => _ElectricUsageScreenState();
}

class _ElectricUsageScreenState extends State<ElectricUsageScreen> {
  intl.NumberFormat numberFormat = intl.NumberFormat.decimalPattern("en_us");
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'استهلاك الكهرباء',
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
          create: (BuildContext context) => ElectricCubit()..getElectricUsage(),
          child: BlocConsumer<ElectricCubit, ElectricState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = ElectricCubit.get(context);
              return state is ElectricLoadingState
                  ? Center(
                      child: shimmerLoading(),
                    )
                  : state is ElectricSuccessState
                      ? state.electric == null
                          ? PlaceHolderWidget(
                              context: context,
                              title: 'لا يوجد بيانات',
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'تاريخ اخر قراءة: ${intl.DateFormat('yyyy-MM-dd hh:mm aa').format(DateTime.parse(cubit.electric!.lastDeviceReadDate ?? DateTime.now().toString()))}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: ColorName.NuturalColor3,
                                      fontSize: Sizes.fontLarge,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height * .4,
                                    decoration: BoxDecoration(
                                        color: ColorName.NuturalColor1,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorName.NuturalColor3,
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: SpeedometerChart.tick(
                                            hasTickSpace: true,
                                            title: Text(
                                              'رصيد الكهرباء من المولد',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontLarge,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            minWidget: Text(
                                              '0 kWh',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontDefault,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            maxWidget: Text(
                                              '450 kWh',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontDefault,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            dimension: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .45,
                                            minValue: 0,
                                            maxValue: cubit.electric!
                                                        .generatorBalance! <
                                                    450
                                                ? 450
                                                : 2000,
                                            value: cubit.electric!
                                                        .generatorBalance! <
                                                    0
                                                ? 0
                                                : cubit.electric!
                                                    .generatorBalance!,
                                            valueWidget: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      ' kWh ',
                                                      style: TextStyle(
                                                        color: cubit.electric!
                                                                    .generatorBalance! <
                                                                80
                                                            ? ColorName
                                                                .errorColor5
                                                            : ColorName
                                                                .NuturalColor5,
                                                        fontSize:
                                                            Sizes.fontDefault,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${cubit.electric!.generatorBalance ?? 0} ',
                                                      style: TextStyle(
                                                        color: cubit.electric!
                                                                    .generatorBalance! <
                                                                80
                                                            ? ColorName
                                                                .errorColor5
                                                            : ColorName
                                                                .NuturalColor5,
                                                        fontSize:
                                                            Sizes.fontDefault,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' : ',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor5,
                                                        fontSize:
                                                            Sizes.fontDefault,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      'الرصيد الحالي',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor5,
                                                        fontSize:
                                                            Sizes.fontSmall,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      ' IQD ',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor3,
                                                        fontSize:
                                                            Sizes.fontSmall,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${numberFormat.format(cubit.electric!.generatorBalanceCost ?? 0)} ',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor3,
                                                        fontSize:
                                                            Sizes.fontSmall,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' : ',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor3,
                                                        fontSize:
                                                            Sizes.fontSmall,
                                                      ),
                                                    ),
                                                    Text(
                                                      'المبلغ المتبقي',
                                                      style: const TextStyle(
                                                        color: ColorName
                                                            .NuturalColor3,
                                                        fontSize:
                                                            Sizes.fontSmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                            pointerColor: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'الرصيد جيد\n 450 - 2000',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: ColorName
                                                            .NuturalColor5),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'الرصيد معتدل\n 200 - 450',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: ColorName
                                                            .NuturalColor5),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'الرصيد منخفض\n 80 - 200',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: ColorName
                                                            .NuturalColor5),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'منخفض جدا\n 0 - 80',
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: ColorName
                                                            .NuturalColor5),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        ' حالة الكهرباء : ',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        ' ${cubit.electric!.relayStatus?.toString() == 'true' ? 'تعمل' : 'متوقف'}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: cubit.electric!.relayStatus!
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: Sizes.fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.circle,
                                        color: cubit.electric!.relayStatus!
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ' مصدر الكهرباء : ',
                                        style: TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        ' ${cubit.electric!.powerSource ?? ''}',
                                        style: TextStyle(
                                          color: cubit.electric!.powerSource ==
                                                  'مولد'
                                              ? Colors.orange
                                              : Colors.green,
                                          fontSize: Sizes.fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.circle,
                                        color: cubit.electric!.powerSource ==
                                                'مولد'
                                            ? Colors.orange
                                            : Colors.green,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: ColorName.NuturalColor2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hide = !hide;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          hide == true
                                              ? 'مزيد من التفاصيل'
                                              : 'أخفاء التفاصيل',
                                          style: TextStyle(
                                              color: ColorName.NuturalColor6),
                                        ),
                                        SizedBox(width: 20),
                                        Icon(hide == true
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward)
                                      ],
                                    ),
                                  ),
                                  hide
                                      ? SizedBox()
                                      : Expanded(
                                          child: Column(
                                          children: [
                                            Text(
                                              'جدول قراءات اخر 10 ايام',
                                              style: TextStyle(
                                                  color:
                                                      ColorName.NuturalColor6,
                                                  fontSize: Sizes.fontLarge,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorName.NuturalColor4,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'التاريخ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: ColorName
                                                              .NuturalColor1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    width: 1,
                                                    height: 20,
                                                    color:
                                                        ColorName.NuturalColor5,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    'القراءة عند بداية اليوم ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: ColorName
                                                            .NuturalColor1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    width: 1,
                                                    height: 20,
                                                    color:
                                                        ColorName.NuturalColor5,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    'القراءة عند نهاية اليوم ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: ColorName
                                                            .NuturalColor1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    width: 1,
                                                    height: 20,
                                                    color:
                                                        ColorName.NuturalColor5,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    'الاستهلاك اليومي',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: ColorName
                                                            .NuturalColor1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: cubit
                                                      .electric!
                                                      .previousGeneratorReading!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    PreviousGeneratorReading
                                                        data = cubit.electric!
                                                                .previousGeneratorReading![
                                                            index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${data.date}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: ColorName
                                                                          .NuturalColor4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Text(
                                                                'kWh ${data.firstGeneratorBalance}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: ColorName
                                                                        .NuturalColor4,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                              Expanded(
                                                                  child: Text(
                                                                'kWh ${data.lastGeneratorBalance}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: ColorName
                                                                        .NuturalColor4,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                              Expanded(
                                                                  child: Column(
                                                                children: [
                                                                  Text(
                                                                    'kWh ${data.generatorConsumption}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: ColorName
                                                                            .NuturalColor4,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                    'IQD ${numberFormat.format(data.generatorConsumptionCost)}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: ColorName
                                                                            .NuturalColor3,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              )),
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: ColorName
                                                                .NuturalColor3,
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ))
                                ],
                              ),
                            )
                      : state is ElectricErrorState
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: SpeedometerChart.tick(
                                    hasTickSpace: true,
                                    minWidget: Text(
                                      '0 kWh',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    maxWidget: Text(
                                      '450 kWh',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    dimension:
                                        MediaQuery.of(context).size.height *
                                            .45,
                                    minValue: 0,
                                    maxValue: 450,
                                    value: 0,
                                    valueWidget: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ' kWh ',
                                              style: TextStyle(
                                                color: ColorName.errorColor5,
                                                fontSize: Sizes.fontDefault,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: ColorName.errorColor5,
                                                fontSize: Sizes.fontDefault,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              ' : ',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontDefault,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'الرصيد الحالي',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontSmall,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ' IQD ',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                              ),
                                            ),
                                            Text(
                                              '0',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                              ),
                                            ),
                                            Text(
                                              ' : ',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                              ),
                                            ),
                                            Text(
                                              'المبلغ المتبقي',
                                              style: const TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    pointerColor: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'الرصيد جيد\n 450 - 2000',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: ColorName.NuturalColor5),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'الرصيد معتدل\n 200 - 450',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: ColorName.NuturalColor5),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'الرصيد منخفض\n 80 - 200',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: ColorName.NuturalColor5),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'منخفض جدا\n 0 - 80',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: ColorName.NuturalColor5),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'سيتم تفعيل هذه الخدمة وربط العدادات بعد تسليم الوحدة السكنية',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor4,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container();
            },
          )),
    );
  }

  shimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
