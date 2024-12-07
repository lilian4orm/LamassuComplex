import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Widget rowTextbuildOffer(
    {required BuildContext context,
      required String text,
      required bool mor,
      required VoidCallback onPress})
{
  return Padding(
    padding: const EdgeInsets.only(left: 32, right: 32, top: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontSmall,
              fontWeight: FontWeight.bold),
        ),

        InkWell(
          onTap: onPress,
          child:mor == true? Text(
            AppLocalizations.of(context)!.view_more,
            style:  TextStyle(
                color: ColorName.NuturalColor3,
                fontSize: Sizes.fontSmall,
                fontWeight: FontWeight.w500),
          ):Text(""),
        ),
      ],
    ),
  );
}