import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/investor/cubit/cubit.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/widgets/service_chart.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});
  static NumberFormat number = NumberFormat.decimalPattern('en-us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'فواتير خدمات ما بعد البيع',
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
        create: (context) => ReportCubit()..getServiceReport(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ServiceLoadingState) {
                return shimmerLoading();
              } else if (state is ServiceSuccessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServiceChart(
                        service: state.service,
                        title: 'تقرير فواتير خدمات ما بعد البيع',
                        isAll: true),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * .95,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    ServiceChart(
                        service: state.service,
                        title: 'تقرير فواتير خدمات ما بعد البيع لهذا اليوم',
                        isAll: false),
                  ],
                );
              } else if (state is ServiceErrorState) {
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
