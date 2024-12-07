import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../request_approved_form.dart';
import 'edit_customer_form.dart';

class ShowCustomerForm extends StatefulWidget {
  const ShowCustomerForm({Key? key});

  @override
  State<ShowCustomerForm> createState() => _ShowCustomerFormState();
}

class _ShowCustomerFormState extends State<ShowCustomerForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("استمارات الحضور",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => FormCubit()..getShowCustomer(),
        child: BlocConsumer<FormCubit, FormAStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ShowCustomerFormsSuccessState) {

              final showCustomer = state.ShowCustomer!;
              String toDateTime(String datetime){
                DateTime dateTime = DateTime.parse(datetime).toLocal();
                String formattedDateTime = DateFormat("dd-MM-yyyy").format(dateTime);

                return formattedDateTime;
              }
              if(showCustomer.results!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: showCustomer.results!.data!.length,
                  itemBuilder: (context, index) {
                    final data = showCustomer.results!.data![index];
                 


                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //     color: data.isYours == true ? ColorName.successColor3 : ColorName.successColor3,
                          border: Border.all(color: ColorName.NuturalColor2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.callerName ?? '',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontLarge,
                                        fontWeight: FontWeight.w500,

                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                    Text(
                                      data.callerPhone ?? '',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor3,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  toDateTime(data.createdAt.toString()) ,
                                  style: const TextStyle(
                                    color: ColorName.NuturalColor3,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if(data.transferredApplicationForm == false)
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditCustomerInquiryForm(
                                              showCustomerForm: data,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.08,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12)),
                                      color: ColorName.NuturalColor2,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(
                                          Icons.edit_note,
                                          color: ColorName.brandPrimary,
                                          size: 30,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.edit,
                                          style: const TextStyle(
                                            color: ColorName.brandPrimary,
                                            fontSize: Sizes.fontDefault,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if(data.transferredApplicationForm == false)
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RequestApprovedForm(data.callerName,data.callerPhone,data.sId),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.08,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12)),
                                      color: ColorName.successColor7,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: ColorName.secondaryLight,
                                          size: 30,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.reservation,
                                          style: const TextStyle(
                                            color: ColorName.secondaryLight,
                                            fontSize: Sizes.fontDefault,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if(data.transferredApplicationForm == true)
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.08,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                    ),
                                    color: ColorName.NuturalColor2,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_download_done,
                                        color: ColorName.successColor6,
                                        size: 25,
                                      ),
                                      Text("تم التحويل للحجز",
                                        style: const TextStyle(
                                          color: ColorName.brandPrimary,
                                          fontSize: Sizes.fontSmall,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else {
               return Center(
                  child: Text(
                    "لايوجد حضور",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else if (state is ShowCustomerFormsErrorState) {
              return Center(
                child: Text(
                  "لايوجد حضور",
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
