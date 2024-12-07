import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/investor/cubit/cubit.dart';
import 'package:lamassu/modules/investor/cubit/state.dart';
import 'package:lamassu/modules/investor/models/service_request_model.dart' as sr;
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ServiceRequestReportScreen extends StatelessWidget {
  const ServiceRequestReportScreen({super.key});
  static NumberFormat number = NumberFormat.decimalPattern('en-us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'طلبات الصيانة والشحن',
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
        create: (context) => ReportCubit()..getServiceRequestReport(),
        child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ServiceRequestLoadingState) {
                return shimmerLoading();
              } else if (state is ServiceRequestSuccessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        children: [
                          Text(
                            'تقرير طلبات الصيانة والشحن الكلي',
                            style: TextStyle(
                              color: ColorName.NuturalColor3,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.serviceRequest.all!.length,
                          itemBuilder: (context, index) {
                            sr.All service = state.serviceRequest.all![index];
                            return Card(
                              color: index % 2 == 0
                                  ? ColorName.successColor3
                                  : ColorName.warningColor3,
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    'عدد طلبات ${service.sId!}',
                                    style: TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: Center(
                                  child: Text(
                                    number.format(service.count),
                                    style: TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        children: [
                          Text(
                            'تقرير طلبات الصيانة والشحن لهذا اليوم',
                            style: TextStyle(
                              color: ColorName.NuturalColor3,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.serviceRequest.today!.length,
                          itemBuilder: (context, index) {
                            sr.All service = state.serviceRequest.all![index];
                            return Card(
                              color: index % 2 == 0
                                  ? ColorName.successColor4
                                  : ColorName.errorColor3,
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    'عدد طلبات ${service.sId!}',
                                    style: TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: Center(
                                  child: Text(
                                    number.format(service.count),
                                    style: TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else if (state is ServiceRequestErrorState) {
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
