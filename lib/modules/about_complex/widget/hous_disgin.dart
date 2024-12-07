import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../models/form_model/form_name.dart';
import '../../../shared/components/card_complex.dart';
import '../../../shared/components/card_details_complex.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

Widget modelsHous(BuildContext context, FormNameModel? complexform) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.of(context)!.models,
        style: TextStyle(
          color: ColorName.NuturalColor5,
          fontSize: Sizes.fontLarge,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16, top: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.62,
          width: double.infinity,
          child: ListView.builder(
            itemCount: complexform!.results!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              ResultsFormName form = complexform.results![index];
              print(complexform.results!.first.name);
              return GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: DetailsComplexScreen(
                      form: form,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  );
                },
                child: complexCard(
                  context: context,
                  form: form,
                ),
              );
            },
          ),
        ),
      ),
      SizedBox(
        height: 100,
      ),
    ],
  );
}
