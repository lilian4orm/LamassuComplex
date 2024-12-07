import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/investor/cubit/cubit.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/widgets/chart_inso.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class HouseReportScreen extends StatelessWidget {
  const HouseReportScreen({super.key});
  static List<Color> colorList = [
    ColorName.successColor7,
    ColorName.errorColor6,
  ];

  static List<Color> colorList2 = [
    ColorName.successColor7,
    ColorName.warningColor5,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الوحدات السكنية',
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ReportCubit()..getHousesReport(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HouseLoadingState) {
                return shimmerLoading();
              } else if (state is HouseSuccessState) {
                Map<String, double> dataMap = {
                  "المباع":
                      double.parse(state.house.numberOfSoldHouses.toString()),
                  "المتبقي": double.parse(
                          state.house.numberOfHouses.toString()) -
                      double.parse(state.house.numberOfSoldHouses.toString()),
                };
                Map<String, double> dataMap2 = {
                  "المباع": double.parse(
                      state.house.numberOfReceivedHouses.toString()),
                  "الموزع":
                      double.parse(state.house.numberOfSoldHouses.toString()) -
                          double.parse(
                              state.house.numberOfReceivedHouses.toString()),
                };
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChartInfoWidget(
                      dataMap: dataMap,
                      colorList: colorList,
                      house: state.house,
                      title: 'مبيعات الوحدات السكنية',
                      title1: 'الوحدات المباعة',
                      title2: 'الوحدات المتبقية',
                      title3: 'اجمالي الوحدات',
                      isAll: true,
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 5),
                    //   height: 1,
                    //   width: MediaQuery.of(context).size.width * .9,
                    //   color: Colors.grey[350],
                    // ),
                    ChartInfoWidget(
                      dataMap: dataMap2,
                      colorList: colorList,
                      house: state.house,
                      title: 'توزيع الوحدات السكنية',
                      title1: 'الوحدات السكنية المستلمة',
                      title2: 'الوحدات السكنية غير المستلمة',
                      title3: 'الوحدات السكنية الكلية',
                      isAll: false,
                      total:
                          double.parse(state.house.numberOfHouses.toString()),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 5),
                    //   height: 1,
                    //   width: MediaQuery.of(context).size.width * .9,
                    //   color: Colors.grey[350],
                    // ),
                  ],
                );
              } else if (state is HouseErrorState) {
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
