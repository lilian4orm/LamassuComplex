import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/components/custom_textformfield.dart';
import '../../../../shared/components/loading.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class complainScreen extends StatefulWidget {
  const complainScreen({Key? key}) : super(key: key);

  @override
  State<complainScreen> createState() => _complainScreenState();
}

class _complainScreenState extends State<complainScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final customerTitleController = TextEditingController();
  final customerDescriptionController = TextEditingController();
  final typeController = TextEditingController();



  String? dropdownValueType = 'اختر نوع الشكوى:';

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.make_complaint,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<OwnerProfileCubit, OwnerProfileStates>(
        listener: (context, state) {
          if (state is complainLoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return loadingDialog();
              },
            );
          }
          if (state is complainSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(50),
                content: Text("تم ارسال الشكوى بنجاح"),
                backgroundColor: Colors.green,
              ),
            );

            customerTitleController.clear();
            customerDescriptionController.clear();
            Navigator.of(context).pop();
          }
          if (state is complainErrorState) {
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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // CustomTextFormField(
                    //     keyboardType: TextInputType.text,
                    //     margin: const EdgeInsets.only(
                    //       top: Sizes.space8,
                    //       bottom: Sizes.space8,
                    //     ),
                    //     controller: customerTitleController,
                    //     hintText: AppLocalizations.of(context)!.address,
                    //     svgPath: Assets.svgs.form.streetSvgrepoCom.path,
                    //     // validator: (value) =>
                    //     //     Validator.validateNameController(value, state)
                    //  ),
                    CustomTextFormField(
                        keyboardType: TextInputType.text,
                        margin: const EdgeInsets.only(
                          top: Sizes.space12,
                          bottom: Sizes.space12,
                        ),
                        maxLength: 400,
                        showMaxLength: true,
                        maxLines: 9,
                        controller: customerDescriptionController,
                        hintText:
                        AppLocalizations.of(context)!.details,

                        validator: (value) =>
                            Validator.validateNumberController(
                                value, state)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.occupation_type,
                            prefixIcon: Icon(
                              Icons.merge_type,
                              color: ColorName.NuturalColor2,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorName.NuturalColor2),
                              // Gray border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey),
                              // Gray border when focused
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          value: dropdownValueType,
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValueType = newValue!;
                              typeController.text = newValue;
                            });
                          },
                          items: <String>['اختر نوع الشكوى:','مشاكل الزبائن', 'تطبيق']
                              .map<DropdownMenuItem<String>>(
                                  (String value) {
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            OwnerProfileCubit.get(context).postComplain(
                               title: "»",
                               description: customerDescriptionController.text,
                               type: typeController.text,
                            );
                          }
                        },
                        child: state is complainLoadingState
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
    );
  }
}

class Validator {
  static String? validateNameController(String? value, OwnerProfileStates? state) {
    if (state is complainErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال العنوان";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "يرجا ادخال العنوان";
    }

    return  null;
  }

  static String? validateNumberController(String? value, OwnerProfileStates? state) {
    if (state is complainErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    return  null;
  }

}
