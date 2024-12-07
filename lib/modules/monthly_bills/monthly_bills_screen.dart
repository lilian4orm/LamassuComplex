import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/monthly_bills/bills_bloc/bills_bloc.dart';
import 'package:lamassu/modules/monthly_bills/bills_bloc/bills_state.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shimmer/shimmer.dart';

class MonthlyBillsScreen extends StatelessWidget {
  const MonthlyBillsScreen({super.key});
  static NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'الفواتير الشهرية',
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => BillsCubit()..fetchBills(),
          child: BlocConsumer<BillsCubit, BillsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is BillsLoadingState) {
                  return shimmerLoading();
                } else if (state is BillsSuccessState) {
                  return state.bills.isEmpty
                      ? PlaceHolderWidget(
                          context: context,
                          title: 'لا يوجد فواتير',
                          image: Image.asset('asset/images/logo.png'))
                      : ListView.builder(
                          itemCount: state.bills.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                                      Text(
                                        'المبلغ: ${numberFormat.format(state.bills[index].price)} دينار',
                                        style: TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontLarge,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'التاريخ: ${state.bills[index].createdAt}',
                                        style: TextStyle(
                                          color: ColorName.NuturalColor3,
                                          fontSize: Sizes.fontSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(state.bills[index].isPaid!
                                          ? 'تم التسديد'
                                          : 'لم يتم التسديد'),
                                      SizedBox(width: 5),
                                      state.bills[index].isPaid!
                                          ? Icon(Icons.done_all,
                                              color: ColorName.successColor6)
                                          : Icon(Icons.close,
                                              color: ColorName.errorColor6),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                } else if (state is BillsErrorState) {
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
