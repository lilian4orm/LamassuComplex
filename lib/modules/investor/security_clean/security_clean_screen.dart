import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/investor/cubit/cubit.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/widgets/security_clean_chart.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class SecurityCleanScreen extends StatelessWidget {
  const SecurityCleanScreen({super.key});
  static NumberFormat number = NumberFormat.decimalPattern('en-us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'فواتير الخدمات الشهرية \n حراسة وتنظيف',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ReportCubit()..getSecurityCleanReport(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SecurityCleanLoadingState) {
                return shimmerLoading();
              } else if (state is SecurityCleanSuccessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecurityCleanChart(security: state.security),
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
                                'تقرير الفواتير  لهذا اليوم',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorName.NuturalColor5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              Text(
                                'عدد الفواتير : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: ColorName.NuturalColor3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${number.format(state.security.todayPaidCount)}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorName.NuturalColor3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              Text(
                                'مبالغ الفواتير : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: ColorName.NuturalColor3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${number.format(state.security.todayPaidPrice!.totalPrice)}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorName.NuturalColor3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                );
              } else if (state is SecurityCleanErrorState) {
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
