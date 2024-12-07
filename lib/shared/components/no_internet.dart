import 'package:flutter/material.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../gen/assets.gen.dart';
import '../style/colors.dart';
import '../style/sizes.dart';

Widget noInternet({
  required BuildContext context,
  required VoidCallback onTap,
}){
  return Padding(
    padding: const EdgeInsets.all(32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlaceHolderWidget(context: context,
            title: AppLocalizations.of(context)!.please_check_your_network,
            image: Assets.illustrations.nointr.svg()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
          child: ElevatedButton(onPressed: onTap, child:
          Text(
            AppLocalizations.of(context)!.try_again,
            style: const TextStyle(
              color: ColorName.secondaryLight,
              fontSize: Sizes.fontDefault,
              fontWeight: FontWeight.w800,
            ),
          ),),
        )
      ],
    ),
  );
}
