import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamassu/shared/components/make_breaks.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/assets.gen.dart';
import '../../models/houses_model.dart';
import '../end_point/end_point.dart';
import '../style/colors.dart';
import '../style/sizes.dart';

Widget saleOffersCard2(
    {required BuildContext context,
    required Data? houseData,
    required String title,
    required bool type}) {
  if (type) {
    if (houseData!.existingType! == title) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Card(
              elevation: 0.18,
              color: ColorName.secondaryLight,
              child: Container(
                height: MediaQuery.of(context).size.height / 7.3,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7.5,
                      width: MediaQuery.of(context).size.height / 7.52,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: imageStorg + houseData.imgs![0],
                          height: MediaQuery.of(context).size.height * .2,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: ColorName.NuturalColor5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${houseData.name}",
                            style: const TextStyle(
                                color: ColorName.NuturalColor5,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            "${addCommasToNumber(houseData.price!)} د.ع",
                            style: TextStyle(
                                color: ColorName.brandSecondary,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              rowHouseDetails(
                                  title: '${houseData.space!} م',
                                  icone: Assets.svgs.vector.svg(
                                      height: 16,
                                      color: ColorName.NuturalColor3)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  height: 13,
                                  width: 1,
                                  color: ColorName.NuturalColor2,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: rowHouseDetails(
                                    title: '${houseData.livingRooms!} معيشة',
                                    icone: Assets.svgs.armchair.svg(
                                        height: 16,
                                        color: ColorName.NuturalColor3)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  height: 13,
                                  width: 1,
                                  color: ColorName.NuturalColor2,
                                ),
                              ),
                              rowHouseDetails(
                                  title: '${houseData.bedRooms!} نوم',
                                  icone: Assets.svgs.bed.svg(
                                      height: 16,
                                      color: ColorName.NuturalColor3)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                width: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: houseData.existingType == "بيع"
                      ? ColorName.successColor1
                      : ColorName.SecandaryYallw1,
                ),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                    child: Text(
                      "${houseData.existingType}",
                      style: TextStyle(
                          color: houseData.existingType == "بيع"
                              ? ColorName.successColor6
                              : ColorName.SecandaryYallw4,
                          fontSize: Sizes.fontSmall,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else
      return SizedBox();
  } else
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Card(
            elevation: 0.18,
            color: ColorName.secondaryLight,
            child: Container(
              height: MediaQuery.of(context).size.height / 7.3,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7.5,
                    width: MediaQuery.of(context).size.height / 7.52,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageStorg + houseData!.imgs![0],
                        height: MediaQuery.of(context).size.height * .2,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorName.NuturalColor5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${houseData.name}",
                          style: const TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontSmall,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "${addCommasToNumber(houseData.price!)} د.ع",
                          style: TextStyle(
                              color: ColorName.brandSecondary,
                              fontSize: Sizes.fontSmall,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            rowHouseDetails(
                                title: '${houseData.space!} م',
                                icone: Assets.svgs.vector.svg(
                                    height: 16,
                                    color: ColorName.NuturalColor3)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                height: 13,
                                width: 1,
                                color: ColorName.NuturalColor2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: rowHouseDetails(
                                  title: '${houseData.livingRooms!} معيشة',
                                  icone: Assets.svgs.armchair.svg(
                                      height: 16,
                                      color: ColorName.NuturalColor3)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                height: 13,
                                width: 1,
                                color: ColorName.NuturalColor2,
                              ),
                            ),
                            rowHouseDetails(
                                title: '${houseData.bedRooms!} نوم',
                                icone: Assets.svgs.bed.svg(
                                    height: 16,
                                    color: ColorName.NuturalColor3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              width: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: houseData.existingType == "بيع"
                    ? ColorName.successColor1
                    : ColorName.SecandaryYallw1,
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: Text(
                    "${houseData.existingType}",
                    style: TextStyle(
                        color: houseData.existingType == "بيع"
                            ? ColorName.successColor6
                            : ColorName.SecandaryYallw4,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}

Widget rowHouseDetails({required String title, required Widget icone}) {
  return Row(children: [
    Text(
      title,
      style: const TextStyle(
          color: ColorName.NuturalColor3,
          fontSize: Sizes.fontExtraSmall,
          fontWeight: FontWeight.w500),
    ),
    const SizedBox(
      width: 4,
    ),
    icone
  ]);
}
