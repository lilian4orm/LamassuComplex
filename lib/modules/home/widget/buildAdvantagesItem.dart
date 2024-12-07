import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../models/advantages_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

Widget buildStoryItem({
  required BuildContext context,
  required ResultsAdvantages advantages,
}) {
  return GestureDetector(onTap: (){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(advantages.title ?? 'مميزاتنا'),
                content:
                    Text(advantages.note ?? advantages.title ?? 'مميزاتنا'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorName.NuturalColor5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'اغلاق',
                        style: TextStyle(
                          color: ColorName.NuturalColor1,
                          fontSize: Sizes.fontDefault,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.notoKufiArabic,
                        ),
                      )),
                ],
              ));
  },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              //height:  MediaQuery.of(context).size.height * .08,
              // width:  MediaQuery.of(context).size.width * 0.22,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageStorg + advantages.image!,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      //  height:  MediaQuery.of(context).size.height * .09,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          //  width: MediaQuery.of(context).size.width * 0.22,
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
                      Assets.images.logo.image(),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            advantages.title!,
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontSmall,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
