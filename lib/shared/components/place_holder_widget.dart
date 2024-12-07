import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/sizes.dart';

Widget PlaceHolderWidget(
    {required BuildContext context, required String title, Widget? image}) {
  var size = MediaQuery.of(context).size;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ColorName.NuturalColor3.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'asset/logo.jpg',
              fit: BoxFit.fill,
              width: size.width * .7,
              height: size.width * .7,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        Text(
          title,
          style: const TextStyle(
              color: ColorName.NuturalColor6,
              fontSize: Sizes.fontDefault,
              fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );
}
