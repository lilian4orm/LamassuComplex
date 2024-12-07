import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/investor/cubit/cubit.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/widgets/money_chart.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class MoneyHousesScreen extends StatefulWidget {
  const MoneyHousesScreen({super.key});

  @override
  State<MoneyHousesScreen> createState() => _MoneyHousesScreenState();
}

class _MoneyHousesScreenState extends State<MoneyHousesScreen> {
  NumberFormat number = NumberFormat.decimalPattern('en-us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'فواتير الوحدات السكنية',
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ReportCubit()..getHousesMoneyReport(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is MoneyHousesLoadingState) {
                return shimmerLoading();
              } else if (state is MoneyHousesSuccessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HousesMoneyWidget(money: state.money),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * .95,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              Text(
                                'تقرير المبيعات لهذا اليوم',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: ColorName.NuturalColor3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          decoration: BoxDecoration(
                              color: ColorName.NuturalColor1,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: .5,
                                  color:
                                      ColorName.NuturalColor3.withOpacity(.5),
                                )
                              ]),
                          child: Text(
                            'المبالغ المستلمة \n ${number.format(state.money.today!.paymentAmount)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorName.NuturalColor3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          decoration: BoxDecoration(
                              color: ColorName.NuturalColor1,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: .5,
                                  color:
                                      ColorName.NuturalColor3.withOpacity(.5),
                                )
                              ]),
                          child: Text(
                            'فواتير اليوم \n ${number.format(state.money.today!.salaryAmount)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorName.NuturalColor3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          decoration: BoxDecoration(
                              color: ColorName.NuturalColor1,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: .5,
                                  color:
                                      ColorName.NuturalColor3.withOpacity(.5),
                                )
                              ]),
                          child: Text(
                            'مبالغ التخفيضات \n ${number.format(state.money.today!.discountAmount)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorName.NuturalColor3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                );
              } else if (state is MoneyHousesErrorState) {
                return PlaceHolderWidget(
                    context: context,
                    title: 'هنالك خلل ما',
                    image: Image.asset('asset/images/logo.png'));
              } else {
                return PlaceHolderWidget(
                    context: context,
                    title: 'هنالك خلل في الاتصال بالانترنيت',
                    image: Image.asset('asset/images/logo.png'));
              }
            }),
      ),
    );
  }

  shimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ));
  }
}
