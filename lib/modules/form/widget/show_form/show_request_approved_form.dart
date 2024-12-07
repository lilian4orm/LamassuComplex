import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/components/make_breaks.dart';
import '../../../../shared/end_point/end_point.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../../cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/state.dart';

class ShowRequestApprovedForm extends StatefulWidget {
  const ShowRequestApprovedForm({Key? key});

  @override
  State<ShowRequestApprovedForm> createState() =>
      _ShowRequestApprovedFormState();
}

class _ShowRequestApprovedFormState extends State<ShowRequestApprovedForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reservation_forms,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => FormCubit()..getShowApplicationForm(),
        child: BlocConsumer<FormCubit, FormAStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ShowApplicationFormSuccessState) {
              final showCustomer = state.showApplicationForm!;
              if (showCustomer.results!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: showCustomer.results!.data!.length,
                  itemBuilder: (context, index) {
                    final data = showCustomer.results!.data![index];
                    String toDateTime(String datetime) {
                      DateTime dateTime = DateTime.parse(datetime).toLocal();
                      String formattedDateTime =
                          DateFormat("dd-MM-yyyy").format(dateTime);

                      return formattedDateTime;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // color:  ColorName.successColor3 ,
                          border: Border.all(color: ColorName.NuturalColor2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: imageStorg +
                                            data.buyerInfo!.idFrontImage!,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .26,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Assets.images.logo.image(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: imageStorg +
                                            data.buyerInfo!.idBackImage!,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Assets.images.logo.image(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.buyerInfo!.customerName ?? '',
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontDefault,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        data.buyerInfo!.customerPhone ?? '',
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontDefault,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        " ${addCommasToNumber(data.houseInfo!.price!)} د.ع ",
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor5,
                                          fontSize: Sizes.fontDefault,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    toDateTime(data.createdAt!),
                                    style: const TextStyle(
                                      color: ColorName.NuturalColor3,
                                      fontSize: Sizes.space10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        data.formName ?? '',
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor3,
                                          fontSize: Sizes.space10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(Assets
                                              .svgs.form.citySvgrepoCom.path)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        data.houseName ?? '',
                                        style: const TextStyle(
                                          color: ColorName.NuturalColor3,
                                          fontSize: Sizes.space10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(Assets
                                              .svgs
                                              .form
                                              .houseWindowSvgrepoCom
                                              .path)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "لاتوجد حجوزات",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else if (state is ShowCustomerFormsErrorState) {
              return Center(
                child: Text(
                  "لاتوجد حجوزات",
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
