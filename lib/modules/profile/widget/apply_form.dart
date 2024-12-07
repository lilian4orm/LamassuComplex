import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/gen/assets.gen.dart';
import 'package:lamassu/modules/form/cubit/cubit.dart';
import 'package:lamassu/modules/form/cubit/state.dart';
import 'package:lamassu/shared/components/custom_textformfield.dart';
import 'package:lamassu/shared/components/loading.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyFormScreenOwner extends StatefulWidget {
  const ApplyFormScreenOwner({Key? key}) : super(key: key);

  @override
  State<ApplyFormScreenOwner> createState() => _ApplyFormScreenOwnerState();
}

class _ApplyFormScreenOwnerState extends State<ApplyFormScreenOwner> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();

  final detailsController = TextEditingController();
  final typeController = TextEditingController();

  String? dropdownValueType;
  late SharedPreferences prefs;

  String? owner;

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      customerNameController.text = prefs.getString('name') ?? '';
      customerPhoneController.text = prefs.getString('phone') ?? '';
      owner = prefs.getString('owner');
    });
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    dropdownValueType = 'اختر النوع:';
    // Fetch the data
    // FormCubit.get(context).howHearAboutUs();
    // FormCubit.get(context).getCenterForms();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.submit_request,
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
            if (state is ApplyFormLoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return loadingDialog();
                },
              );
            }
            if (state is ApplyFormSuccessState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(50),
                  content: Text("تم ارسال الطلب بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );

              customerNameController.clear();
              customerPhoneController.clear();
              detailsController.clear();
              Navigator.of(context).pop();
            }
            if (state is ApplyFormErrorState) {
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          keyboardType: TextInputType.text,
                          readonly: true,
                          margin: const EdgeInsets.only(
                            top: Sizes.space8,
                            bottom: Sizes.space8,
                          ),
                          controller: customerNameController,
                          hintText: AppLocalizations.of(context)!.customer_name,
                          svgPath: Assets.svgs.userRounded.path,
                          validator: (value) =>
                              Validator.validateNameController(value, state)),
                      CustomTextFormField(
                          readonly: true,
                          keyboardType: TextInputType.number,
                          margin: const EdgeInsets.only(
                            top: Sizes.space12,
                            bottom: Sizes.space12,
                          ),
                          maxLines: 1,
                          controller: customerPhoneController,
                          hintText:
                              AppLocalizations.of(context)!.customer_phone,
                          svgPath: Assets.svgs.phone.path,
                          validator: (value) =>
                              Validator.validateNumberController(value, state)),
                      Divider(color: ColorName.brandLight),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        margin: const EdgeInsets.only(
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        maxLines: 6,
                        maxLength: 300,
                        showMaxLength: true,
                        onChanged: (val) {
                          _formKey.currentState!.validate();
                        },
                        controller: detailsController,
                        validator: (val) {
                          if (detailsController.text.isEmpty) {
                            return "حقل مطلوب";
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.details,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FormCubit.get(context).postApplyFormOwner(
                                note: detailsController.text,
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Validator {
  static String? validateNameController(String? value, FormAStates? state) {
    if (state is ApplyFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? validateNumberController(String? value, FormAStates? state) {
    if (state is ApplyFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }

  static String? familyCountController(String? value, FormAStates? state) {
    if (state is ApplyFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return null;
  }
}
