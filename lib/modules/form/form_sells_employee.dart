import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:lamassu/modules/form/widget/customer_form.dart';
import 'package:lamassu/modules/form/widget/request_approved_form.dart';
import 'package:lamassu/modules/form/widget/show_form/show_apply_form.dart';
import 'package:lamassu/modules/form/widget/show_form/show_customer_form.dart';
import 'package:lamassu/modules/form/widget/show_form/show_request_approved_form.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/style/sizes.dart';
import 'widget/apply_form.dart';

class FormSelleEmployee extends StatelessWidget {
  const FormSelleEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.application_and_inquiry_form,
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!
                        .provides_necessary_forms_sales_staff,
                    style: const TextStyle(
                      color: ColorName.NuturalColor5,
                      fontSize: Sizes.fontDefault,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CustomerInquiryForm(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2, // Adjust elevation as needed
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.brandPrimary,
                          ),
                          child: Center(
                            child: Text(
                              "استمارة حضور",
                              style: const TextStyle(
                                color: ColorName.secondaryLight,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ShowCustomerForm(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.secondaryLight,
                          ),
                          child: Center(
                            child: Text(
                              "الحضور",
                              style: const TextStyle(
                                color: ColorName.brandPrimary,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: RequestApprovedForm("", "", ''),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.brandPrimary,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .reservation_form_apartment,
                              style: const TextStyle(
                                color: ColorName.secondaryLight,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ShowRequestApprovedForm(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.secondaryLight,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.view_reservations,
                              style: const TextStyle(
                                color: ColorName.brandPrimary,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ApplyFormScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.brandPrimary,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.submit_request,
                              style: const TextStyle(
                                color: ColorName.secondaryLight,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ShowApplyForm(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorName.secondaryLight,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.view_requests,
                              style: const TextStyle(
                                color: ColorName.brandPrimary,
                                fontSize: Sizes.fontLarge,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
