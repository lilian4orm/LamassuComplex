import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../models/quard_visits.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';

class VisitorLogScreen extends StatelessWidget {
  const VisitorLogScreen({super.key, required this.cubit});
  final GuardVisits? cubit;

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ColorName.brandPrimary,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "عدد الزوار",
                        style: const TextStyle(
                          color: ColorName.secondaryLight,
                          fontSize: Sizes.fontDefault,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: ColorName.brandPrimary,
                          child: Center(
                              child: Text(
                            "${cubit!.results!.count}",
                            style: const TextStyle(
                              color: ColorName.secondaryLight,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("المالك",
                            style: const TextStyle(
                              color: ColorName.brandPrimary,
                              fontSize: Sizes.fontLarge,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("هاتف المالك",
                            textAlign: TextAlign.center,
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
                  itemCount: cubit!.results!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final visit = cubit!.results!.data![index];
                    final formattedDate = DateFormat('yyyy-MM-dd hh:mm aa')
                        .format(DateTime.parse(visit.createdAt!));

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorName.successColor1,
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "${visit.ownerName}",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: ColorName.brandPrimary,
                                      fontSize: Sizes.fontSmall,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${visit.ownerPhone}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: ColorName.brandPrimary,
                                    fontSize: Sizes.fontSmall,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: ColorName.brandPrimary,
                                    fontSize: Sizes.space10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
        ));
  }
}
