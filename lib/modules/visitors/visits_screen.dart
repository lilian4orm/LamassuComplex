import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/visitors/cubit.dart';
import 'package:lamassu/modules/visitors/state.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';

class VisitsScreen extends StatelessWidget {
  const VisitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "الزوار",
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => VisitsCubit()..fetchVisits(),
          child: BlocConsumer<VisitsCubit, VisitordState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is VisitordSuccessState) {
                  return state.visitor.results!.data!.isEmpty
                      ? PlaceHolderWidget(
                          context: context,
                          title: "لايوجد زوار",
                          image: Image.asset('asset/images/logo.png'),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorName.NuturalColor2,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorName.NuturalColor3,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "عدد الزيارات",
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor6,
                                          fontSize: Sizes.fontDefault,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                        "${state.visitor.results!.count}",
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor6,
                                          fontSize: Sizes.fontDefault,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorName.NuturalColor1,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("الحارس",
                                            style: const TextStyle(
                                              color: ColorName.brandPrimary,
                                              fontSize: Sizes.fontLarge,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text("هاتف الحارس",
                                            style: const TextStyle(
                                              color: ColorName.brandPrimary,
                                              fontSize: Sizes.fontLarge,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text("التاريخ",
                                            style: const TextStyle(
                                              color: ColorName.brandPrimary,
                                              fontSize: Sizes.fontLarge,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      state.visitor.results!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final visit =
                                        state.visitor.results!.data![index];
                                    final formattedDate =
                                        DateFormat('yyyy-MM-dd hh:mm').format(
                                            DateTime.parse(visit.createdAt!));

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorName.successColor1,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorName.NuturalColor3,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${visit.guardName}",
                                                  style: const TextStyle(
                                                    color:
                                                        ColorName.brandPrimary,
                                                    fontSize: Sizes.fontSmall,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${visit.guardPhone}",
                                                  style: const TextStyle(
                                                    color:
                                                        ColorName.brandPrimary,
                                                    fontSize: Sizes.fontSmall,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  formattedDate,
                                                  style: const TextStyle(
                                                    color:
                                                        ColorName.brandPrimary,
                                                    fontSize: Sizes.space10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                } else if (state is VisitordErrorState) {
                  return PlaceHolderWidget(
                    context: context,
                    title: "هنالك خلل ما",
                    image: Image.asset('asset/images/logo.png'),
                  );
                } else {
                  return shimmerLoading();
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
