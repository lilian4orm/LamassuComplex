import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../gen/assets.gen.dart';

import '../../../shared/components/custom_textformfield.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class CustomerInquiryForm extends StatefulWidget {
  const CustomerInquiryForm({Key? key}) : super(key: key);

  @override
  State<CustomerInquiryForm> createState() => _CustomerInquiryFormState();
}

class _CustomerInquiryFormState extends State<CustomerInquiryForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final occupationController = TextEditingController();
  final callerGovernorateController = TextEditingController();
  final addressController = TextEditingController();
  final familyCountController = TextEditingController();
  String? areaController;
  final reasonController = TextEditingController();
  String? formIdController;
  String? selectedSource;
  String? dropdownValuepaymentType = 'بغداد';
  @override
  void initState() {
    super.initState();
    callerGovernorateController.text = dropdownValuepaymentType!;
    // Fetch the data
    // FormCubit.get(context).howHearAboutUs();
    // FormCubit.get(context).getCenterForms();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "استمارة الحضور",
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<FormCubit, FormAStates>(
          listener: (context, state) {
            if (state is CustomerFormLoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return loadingDialog();
                },
              );
            }
            if (state is CustomerFormSuccessState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(50),
                  content: Text("تم الارسال بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();

              nameController.clear();
              numberController.clear();
              occupationController.clear();

              //callerGovernorateController.clear();
              familyCountController.clear();
              reasonController.clear();
              areaController = null;
            }
            if (state is CustomerFormErrorState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(50),
                  content: Text("حدث خطا"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            var hearResults = FormCubit.get(context).howHearData?.results;
            // var centerResults = FormCubit.get(context).FormName2?.results;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: nameController,
                              hintText:
                                  AppLocalizations.of(context)!.caller_name,
                              svgPath: Assets.svgs.userRounded.path,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى ادخال اسم المتصل";
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              keyboardType: TextInputType.number,
                              margin: const EdgeInsets.only(
                                top: Sizes.space12,
                                bottom: Sizes.space12,
                              ),
                              controller: numberController,
                              maxLength: 11,
                              showMaxLength: true,
                              hintText:
                                  AppLocalizations.of(context)!.caller_number,
                              svgPath: Assets.svgs.phone.path,
                              validator: (value) {
                                if (value == null ||
                                    value.length < 11 ||
                                    value.length > 11) {
                                  return "يرجى ادخال رقم المتصل";
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: occupationController,
                              hintText: AppLocalizations.of(context)!
                                  .caller_occupation,
                              svgPath: Assets.svgs.jobLaptopSvgrepoCom.path,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى ادخال المهنة";
                                }
                                return null;
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .residence_address,
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: ColorName.NuturalColor3,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorName.NuturalColor2),
                                  // Gray border
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  // Gray border when focused
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              value: callerGovernorateController.text,
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValuepaymentType = newValue!;
                                  callerGovernorateController.text = newValue;
                                });
                              },
                              items: <String>[
                                'بغداد',
                                'البصرة',
                                'ذي قار',
                                'المثنى',
                                'القادسية',
                                'النجف',
                                'واسط',
                                'بابل',
                                'كربلاء',
                                'الموصل',
                                'دهوك',
                                'أربيل',
                                'السليمانية',
                                'صلاح الدين',
                                'ديالى',
                                'الأنبار',
                                'نينوى',
                                'كركوك',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontLarge,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: addressController,
                              hintText: "المنطقة",
                              svgPath: Assets.svgs.arrowleft.path,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى ادخال العنوان";
                                }
                                return null;
                              }),
                          // CustomTextFormField(
                          //     keyboardType: TextInputType.number,
                          //     margin: const EdgeInsets.only(
                          //       top: Sizes.space8,
                          //       bottom: Sizes.space8,
                          //     ),
                          //     controller: familyCountController,
                          //     hintText: AppLocalizations.of(context)!
                          //         .family_members_count,
                          //     svgPath: Assets.svgs.familySvgrepoCom.path,
                          //     validator: (value) =>
                          //         Validator.familyCountController(
                          //             value, state)),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // DropdownButtonFormField<String>(
                          //   decoration: InputDecoration(
                          //     hintText: AppLocalizations.of(context)!.models,
                          //     prefixIcon: Icon(
                          //       Icons.model_training,
                          //       color: ColorName.NuturalColor2,
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: ColorName.NuturalColor2),
                          //       // Gray border
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.grey),
                          //       // Gray border when focused
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //   ),
                          //   value: formIdController,
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       formIdController = newValue;
                          //     });
                          //   },
                          //   items: centerResults?.map((result) {
                          //         return DropdownMenuItem<String>(
                          //           value: result.sId,
                          //           child: Text(
                          //             result.name ?? '',
                          //             style: const TextStyle(
                          //               color: ColorName.NuturalColor5,
                          //               fontSize: Sizes.fontLarge,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //         );
                          //       }).toList() ??
                          //       [],
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // formIdController == null
                          //     ? SizedBox()
                          //     : DropdownButtonFormField<String>(
                          //         decoration: InputDecoration(
                          //           hintText: AppLocalizations.of(context)!
                          //               .building_space,
                          //           prefixIcon: Icon(
                          //             Icons.space_bar,
                          //             color: ColorName.NuturalColor4,
                          //           ),
                          //           enabledBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: ColorName.NuturalColor2),
                          //             // Gray border
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //           focusedBorder: OutlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.grey),
                          //             // Gray border when focused
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //         ),
                          //         value: areaController,
                          //         onChanged: (newValue) {
                          //           setState(() {
                          //             areaController = newValue;
                          //           });
                          //         },
                          //         items: centerResults
                          //                 ?.where((id) =>
                          //                     id.sId == formIdController)
                          //                 .first
                          //                 .totalSpace!
                          //                 .map((result) {
                          //               return DropdownMenuItem<String>(
                          //                 value: result.toString(),
                          //                 child: Text(
                          //                   '${result ?? ''}',
                          //                   style: const TextStyle(
                          //                     color: ColorName.NuturalColor5,
                          //                     fontSize: Sizes.fontLarge,
                          //                     fontWeight: FontWeight.w500,
                          //                   ),
                          //                 ),
                          //               );
                          //             }).toList() ??
                          //             [],
                          //       ),

                          // CustomTextFormField(
                          //     keyboardType: TextInputType.number,
                          //     margin: const EdgeInsets.only(
                          //       top: Sizes.space8,
                          //       bottom: Sizes.space8,
                          //     ),
                          //     controller: areaController,
                          //     hintText:
                          //         AppLocalizations.of(context)!.required_area,
                          //     svgPath: Assets.svgs.vector.path,
                          //     validator: (value) =>
                          //         Validator.reasonController(value, state)),
                          SizedBox(
                            height: 8,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .source_of_information,
                              prefixIcon: Icon(
                                Icons.social_distance,
                                color: ColorName.NuturalColor2,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorName.NuturalColor2),
                                // Gray border
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                // Gray border when focused
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            value: selectedSource,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSource = newValue;
                              });
                            },
                            items: hearResults?.map((result) {
                                  return DropdownMenuItem<String>(
                                    value: result.name,
                                    child: Text(
                                      result.name ?? '',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontDefault,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFormField(
                            keyboardType: TextInputType.text,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            maxLength: 200,
                            maxLines: 4,
                            showMaxLength: true,
                            controller: reasonController,
                            hintText: "ملاحظة",
                            // validator: (value) =>
                            //     Validator.reasonController(value, state),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                print(formKey.currentState!.validate());
                                if (formKey.currentState!.validate()) {
                                  FormCubit.get(context).postCustomerForm(
                                    caller_name: nameController.text,
                                    caller_phone: numberController.text,
                                    caller_job: occupationController.text,
                                    caller_governorate:
                                        callerGovernorateController.text,
                                    caller_address: addressController.text,
                                    family_members: 0,
                                    about_us: selectedSource!,
                                    space_required: 200,
                                    call_reason: reasonController.text,
                                    form_id: '6666e1d675b7f5152c4a87d3',
                                  );
                                }
                              },
                              child: state is howHearLoadingState
                                  ? CircularProgressIndicator()
                                  : Text(
                                      AppLocalizations.of(context)!.send,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: ColorName.secondaryLight,
                                          ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Validator {
  static String? validateNameController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال اسم المتصل";
      }
      return null;
    }

    return null;
  }

  static String? validateNumberController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.length < 11 || value.length > 11) {
        return "يرجا ادخال رقم المتصل";
      }
      return null;
    }

    return null;
  }

  static String? occupationController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return null;
    }

    return null;
  }

  static String? addressController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال العنوان";
      }
      return null;
    }

    return null;
  }

  static String? familyCountController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال عدد افراد الاسره";
      }
      return null;
    }

    return null;
  }

  static String? sourceController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }

    return null;
  }

  static String? areaController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }

    return null;
  }

  static String? reasonController(String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }

    return null;
  }
}
