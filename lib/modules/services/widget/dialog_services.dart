import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/style/colors.dart';

Widget servicesDialog({
  required BuildContext context,
  required bool bottom,
  required String title,
  required String titleBottom,
  required String subtitle,
  required VoidCallback onTap,
  required TextEditingController note,
}) {
  final formKey = GlobalKey<FormState>();
  return AlertDialog(
    title: Text(
      title,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: ColorName.NuturalColor6,
          ),
      textAlign: TextAlign.center,
    ),
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorName.NuturalColor3,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            ColorName.NuturalColor6,
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            onTap();
          }
        },
        child: Text(
          titleBottom,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: ColorName.secondaryLight,
              ),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      if (bottom == true)
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              ColorName.NuturalColor2,
            ),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: Colors.black),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorName.NuturalColor6,
                ),
          ),
        ),
    ],
  );
}
