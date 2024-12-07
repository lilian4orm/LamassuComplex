import 'package:flutter/material.dart';
import '../../models/owner_profile_model.dart';
import '../../shared/components/make_breaks.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GuardSalaryScreen extends StatelessWidget {
  final OwnerProfileModel? salary;

  const GuardSalaryScreen({Key? key, required this.salary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.salary,
          style: TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorName
            .secondaryLight,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: ColorName.secondaryLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(context, "الراتب الاسمي", ColorName.successColor2,
                addCommasToNumber(salary?.results?.salary ?? 0)), // Format salary amount
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.salary_details,
              style: TextStyle(
                color: ColorName.NuturalColor5,
                fontSize: Sizes.fontDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: buildRow(
                  context, AppLocalizations.of(context)!.salary, ColorName.NuturalColor1, AppLocalizations.of(context)!.the_date),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: salary?.results?.salaryStaff?.length ?? 0,
                itemBuilder: (context, index) {
                  final salaryData = salary?.results?.salaryStaff?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: ExpansionTile(
                      collapsedIconColor: ColorName.brandPrimary,
                      iconColor: ColorName.brandPrimary,
                      collapsedBackgroundColor: ColorName.NuturalColor1,
                      backgroundColor: ColorName.successColor2,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            addCommasToNumber(salaryData?.pureMoney ?? 0), // Format salary amount
                            style: TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${salaryData?.paymentDate}",
                            style: TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        InkWell(
                          onTap: () {
                            if (salaryData?.discounts != null)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!.discounts,
                                      style: TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    content: ListTile(

                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: salaryData!.discounts!
                                            .map((discount) {
                                          return Text(
                                            "- ${addCommasToNumber(discount.price ?? 0)} IQD ${discount.note ?? ''}",
                                            style: TextStyle(
                                              color: ColorName.NuturalColor5,
                                              fontSize: Sizes.fontDefault,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.deductions,
                                  style: TextStyle(
                                    color: ColorName.NuturalColor5,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${addCommasToNumber(salaryData?.allDiscounts ?? 0)} IQD",
                                  style: TextStyle(
                                    color: ColorName.errorColor5,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (salaryData?.additional != null)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!.extras,
                                      style: TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    content: ListTile(
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: salaryData!.additional!
                                            .map((additional) {
                                          return Text(
                                            "- ${addCommasToNumber(additional.price ?? 0)} IQD ${additional.note ?? ''}",
                                            style: TextStyle(
                                              color: ColorName.NuturalColor5,
                                              fontSize: Sizes.fontDefault,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.incentives,
                                  style: TextStyle(
                                    color: ColorName.NuturalColor5,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${addCommasToNumber(salaryData?.allAdditional ?? 0)} IQD",
                                  style: TextStyle(
                                    color: ColorName.SecandaryYallw4,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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

  Widget buildRow(
      BuildContext context, String title, Color color, String amount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontDefault,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                amount,
                style: TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontDefault,
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
