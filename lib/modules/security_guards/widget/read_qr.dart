import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/check_qr_model.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class ReadQrScreen extends StatelessWidget {
  const ReadQrScreen({Key? key, required this.readCheckQr}) : super(key: key);
  final CheckQrModel? readCheckQr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.brandPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.brandPrimary,
        title: Text(
          "الكشف عن زائر",
          style: const TextStyle(
            color: ColorName.secondaryLight,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: ColorName.secondaryLight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      if (readCheckQr!.results!.name != null)
                        buildRow(
                            context, "الاسم", "${readCheckQr!.results!.name}"),
                      if (readCheckQr!.results!.phone != null)
                        buildRow(context, "رقم الهاتف",
                            "${readCheckQr!.results!.phone}"),
                      if (readCheckQr!.results!.formName != null)
                        buildRow(context, "نموذج",
                            "${readCheckQr!.results!.formName}"),
                      if (readCheckQr!.results!.houseName != null)
                        buildRow(context, "رقم البيت",
                            "${readCheckQr!.results!.houseName}"),
                      if (readCheckQr!.results!.formCode != null)
                        buildRow(context, "كود الوحدة السكنية",
                            "${readCheckQr!.results!.formCode}"),
                      if (readCheckQr!.results!.formStreetNumber != null)
                        buildRow(context, "رقم الشارع",
                            "${readCheckQr!.results!.formStreetNumber}"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 42),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                        style: const TextStyle(
                          color: ColorName.secondaryLight,
                          fontSize: Sizes.fontLarge,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 6.4,
            right: 0,
            left: 0,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorName.NuturalColor1,
              child: Assets.images.logo.image(fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(BuildContext context, String title, String body) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  color: ColorName.NuturalColor4,
                  fontSize: Sizes.fontLarge,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              body,
              style: const TextStyle(
                color: ColorName.brandPrimary,
                fontSize: Sizes.fontLarge,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
