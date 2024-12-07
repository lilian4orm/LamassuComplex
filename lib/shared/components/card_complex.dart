import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../../models/form_model/form_name.dart';
import '../end_point/end_point.dart';

Widget complexCard({
  required BuildContext context,
  required ResultsFormName form,
}) {
  String name = form.name!;
  String buildingtype = form.buildingType!;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Card(
      elevation: 0.18,
      color: ColorName.secondaryLight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: form.images!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageStorg + form.images!.last,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Assets.images.logo.image(),
                      )
                    : Assets.images.logo.image(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          rowcomplexDetails(
                            title: "اسم آلنموذج : ",
                            icone: Assets.svgs.vector.svg(
                              height: 16,
                              color: ColorName.NuturalColor3,
                            ),
                          ),
                          Text(
                            "$name",
                            style: const TextStyle(
                                color: ColorName.NuturalColor3,
                                fontSize: Sizes.fontExtraSmall,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          rowcomplexDetails(
                            title: "نوع البناء : ",
                            icone: Assets.svgs.comparage.svg(
                              height: 16,
                              color: ColorName.NuturalColor3,
                            ),
                          ),
                          Text(
                            "$buildingtype",
                            style: const TextStyle(
                                color: ColorName.NuturalColor3,
                                fontSize: Sizes.fontExtraSmall,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget rowcomplexDetails({
  required String title,
  required Widget icone,
}) {
  return Row(children: [
    icone,
    const SizedBox(
      width: 4,
    ),
    Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: ColorName.NuturalColor3,
              fontSize: Sizes.fontExtraSmall,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
  ]);
}
