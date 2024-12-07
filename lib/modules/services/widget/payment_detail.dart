import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/salary_owner_services_model.dart';
import '../../../shared/components/make_breaks.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class paymentDetail extends StatelessWidget {
  const paymentDetail({
    super.key,
    required this.paymentDetails,
    required this.index,
  });

  final ResultsSalary paymentDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorName.NuturalColor1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          collapsedIconColor: ColorName.brandPrimary,
          shape: Border.all(color: Colors.grey, width: 0.1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  paymentDetails.serviceName!,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  '${addCommasToNumber(paymentDetails.salaryAmount!)} IQD',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  paymentDetails.date!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Text(
              //   paymentDetails.serviceType!,
              //   style: TextStyle(
              //     color: ColorName.NuturalColor5,
              //     fontSize: Sizes.fontSmall,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.price,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontExtraSmall,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.payment_date,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontExtraSmall,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.payment_status,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontExtraSmall,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: paymentDetails.payments!.length,
                itemBuilder: (context, paymentIndex) {
                  var payment = paymentDetails.payments![paymentIndex];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${addCommasToNumber(payment.amount!)} IQD',
                            style: TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontSmall,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            payment.date!,
                            style: TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontSmall,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            payment.amount! == 0
                                ? "لم يتم التسديد"
                                : payment.desc != null
                                    ? '${payment.desc} '
                                    : "تم التسديد",
                            style: TextStyle(
                              color: payment.amount! == 0
                                  ? ColorName.errorColor5
                                  : payment.desc == "تم التسديد"
                                      ? ColorName.successColor7
                                      : payment.desc == "تم التسديد"
                                          ? ColorName.successColor7
                                          : ColorName.successColor7,
                              fontSize: Sizes.fontSmall,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidgetDetail extends StatelessWidget {
  const NewWidgetDetail({
    super.key,
    required this.provider,
  });
  final SalaryServicesModel provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.invoices,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 40,
              color: ColorName.NuturalColor1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.service,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    AppLocalizations.of(context)!.price,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.order_date,
                    style: TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Text(
                  //   AppLocalizations.of(context)!.service_type,
                  //   style: TextStyle(
                  //     color: ColorName.NuturalColor5,
                  //     fontSize: Sizes.fontSmall,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.results!.length,
              itemBuilder: (context, index) {
                return paymentDetail(
                    paymentDetails: provider.results![index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
