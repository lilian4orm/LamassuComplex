import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamassu/shared/components/make_breaks.dart';
import 'package:shimmer/shimmer.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/houses_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

Widget houseOffersCard({
  required BuildContext context,
  required Data? houseData,
  required String title,
}) {
  if (houseData!.existingType! == title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        elevation: 0.18,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                // MediaQuery.of(context).size.width / 6.3,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageStorg + houseData.imgs![0],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
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
                            ))),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                houseData.name!,
                                style: const TextStyle(
                                    color: ColorName.NuturalColor5,
                                    fontSize: Sizes.fontSmall,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${addCommasToNumber(houseData.price!)} د.ع ",
                                style: const TextStyle(
                                    color: ColorName.brandSecondary,
                                    fontSize: Sizes.fontSmall,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          rowHouseDetails(
                              title: "${houseData.space} م",
                              icone: Assets.svgs.vector.svg(
                                  height: 16, color: ColorName.NuturalColor3)),
                          Container(
                            height: 13,
                            width: 1,
                            color: ColorName.NuturalColor2,
                          ),
                          rowHouseDetails(
                              title: "${houseData.livingRooms} معيشة ",
                              icone: Assets.svgs.armchair.svg(
                                  height: 16, color: ColorName.NuturalColor3)),
                          Container(
                            height: 13,
                            width: 1,
                            color: ColorName.NuturalColor2,
                          ),
                          rowHouseDetails(
                              title: "${houseData.bedRooms} نوم",
                              icone: Assets.svgs.bed.svg(
                                  height: 16, color: ColorName.NuturalColor3)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else
    return SizedBox();
}

Widget rowHouseDetails({required String title, required Widget icone}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: const TextStyle(
                  color: ColorName.NuturalColor3,
                  fontSize: Sizes.fontExtraSmall,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        FittedBox(fit: BoxFit.scaleDown, child: icone)
      ]),
    ),
  );
}
