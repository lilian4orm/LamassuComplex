import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/fines/cubit.dart';
import 'package:lamassu/modules/fines/state.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class FinesScreen extends StatelessWidget {
  const FinesScreen({super.key});
  static NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'الغرامات الشهرية',
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => FinesCubit()..fetchFines(),
          child: BlocConsumer<FinesCubit, FinesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FinesLoadingState) {
                  return shimmerLoading();
                } else if (state is FinesSuccessState) {
                  return state.fines.isEmpty
                      ? PlaceHolderWidget(
                          context: context,
                          title: 'لا يوجد غرامات',
                          image: Image.asset('asset/images/logo.png'))
                      : ListView.builder(
                          itemCount: state.fines.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'تاريخ الغرامة: ${state.fines[index].date ?? ''}',
                                              style: TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'نوع الغرامة: ${state.fines[index].finesTypeName ?? ''}',
                                              style: TextStyle(
                                                color: ColorName.NuturalColor3,
                                                fontSize: Sizes.fontSmall,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'مبلغ الغرامة: ${numberFormat.format(state.fines[index].amount)} دينار',
                                          style: TextStyle(
                                            color: ColorName.brandSecondary,
                                            fontSize: Sizes.fontDefault,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Text(
                                          'سبب الغرامة: ${state.fines[index].fineReason} ',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: ColorName.NuturalColor3,
                                            fontSize: Sizes.fontSmall,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Text(
                                          'الملاحظات : ${state.fines[index].note}',
                                          maxLines: null,
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: ColorName.NuturalColor3,
                                            fontSize: Sizes.fontSmall,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'حالة دفع الغرامة: ${state.fines[index].isPaid! ? 'تم الدفع' : 'لم يتم الدفع'}',
                                        style: TextStyle(
                                          color: state.fines[index].isPaid!
                                              ? ColorName.NuturalColor3
                                              : ColorName.errorColor4,
                                          fontSize: Sizes.fontSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'تاريخ دفع الغرامة: ${state.fines[index].paidDate ?? 'لم يتم الدفع بعد'}',
                                        style: TextStyle(
                                          color: ColorName.NuturalColor3,
                                          fontSize: Sizes.fontSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                } else if (state is FinesErrorState) {
                  return PlaceHolderWidget(
                      context: context,
                      title: 'هنالك خلل ما',
                      image: Image.asset('asset/images/logo.png'));
                } else {
                  return Text('error');
                }
              }),
        ));
  
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
