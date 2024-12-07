import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/salary_owner_model.dart';
import '../../../shared/components/make_breaks.dart';
import '../../../shared/components/place_holder_widget.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key, required this.payments})
      : super(key: key);

  final List<Payments> payments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.payment_details,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            if (payments.isNotEmpty)
              Container(
                height: 40,
                color: ColorName.NuturalColor1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.payments,
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.amounts,
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.payment_date,
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.payment_status,
                      style: TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            if (payments.isNotEmpty)
              Expanded(
                child: buildAnimatedPaymentList(context),
              ),
            if (payments.isEmpty)
              Center(
                child: PlaceHolderWidget(
                  context: context,
                  title:
                      AppLocalizations.of(context)!.there_ar_payment_accounts,
                  image: Assets.illustrations.favor.svg(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedPaymentList(BuildContext context) {
    return ListView.builder(
      itemCount: payments.length,
      itemBuilder: (context, index) {
        return buildAnimatedPaymentCard(context, payments[index], index);
      },
    );
  }

  Widget buildAnimatedPaymentCard(
      BuildContext context, Payments payment, int index) {
    return AnimatedBuilder(
      animation: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Interval(0.1 * index, 1.0, curve: Curves.decelerate),
        ),
      ),
      builder: (context, child) {
        return Opacity(
          opacity: Tween<double>(begin: 0, end: 1).evaluate(
            CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Interval(0.1 * index, 1.0, curve: Curves.decelerate),
            ),
          ),
          child: child,
        );
      },
      child: buildPaymentCard(context, payment, index + 1),
    );
  }

  Widget buildPaymentCard(
      BuildContext context, Payments payment, int paymentNumber) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.voucher_number,
                    style: TextStyle(
                      color: ColorName.NuturalColor6,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    payment.invoiceNumber != null
                        ? payment.invoiceNumber.toString()
                        : "...",
                    style: TextStyle(
                      color: ColorName.NuturalColor6,
                      fontSize: Sizes.fontSmall,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.note,
                      style: TextStyle(
                        color: ColorName.NuturalColor6,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      payment.desc != null ? payment.desc! : "...",
                      style: TextStyle(
                        color: ColorName.NuturalColor6,
                        fontSize: Sizes.fontSmall,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 0.03,
        color: ColorName.secondaryLight,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  ' $paymentNumber -',
                  style: TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                payment.amount != null
                    ? '${addCommasToNumber(payment.amount!)} ${payment.isDollar ?? true ? '\$' : 'IQD'}'
                    : "       0        ",
                style: TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${payment.date}',
                style: TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${payment.status}',
                style: TextStyle(
                  color: payment.status == "تم التسديد"
                      ? ColorName.successColor7
                      : payment.status == "لم يتم التسديد"
                          ? ColorName.errorColor6
                          : ColorName.warningColor6,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
