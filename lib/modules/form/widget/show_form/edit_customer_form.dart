import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../models/show_customer_form_model.dart';
import '../../../../shared/components/custom_textformfield.dart';
import '../../../../shared/components/loading.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';



class EditCustomerInquiryForm extends StatefulWidget {
  const EditCustomerInquiryForm({Key? key, required this.showCustomerForm}) : super(key: key);
  final Data showCustomerForm;

  @override
  State<EditCustomerInquiryForm> createState() => _CustomerInquiryFormState();
}

class _CustomerInquiryFormState extends State<EditCustomerInquiryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController occupationController;
  late TextEditingController  callerGovernorateController;
  late TextEditingController addressController;
  late TextEditingController familyCountController;
  late TextEditingController areaController;
  late TextEditingController reasonController;
  String? formIdController;
  String? selectedSource;

  String? formI;
  String? select;
  String? Source;
  String? formller;

  String? dropdownValuepaymentType ;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.showCustomerForm.callerName);
    numberController = TextEditingController(text: widget.showCustomerForm.callerPhone);
    occupationController = TextEditingController(text: widget.showCustomerForm.callerJob);
    callerGovernorateController =  TextEditingController(text:widget.showCustomerForm.callerGovernorate);
    familyCountController = TextEditingController(text: widget.showCustomerForm.callerFamilyMembers.toString());
    addressController = TextEditingController(text: widget.showCustomerForm.callerAddress.toString());
    areaController = TextEditingController(text: widget.showCustomerForm.spaceRequired);
    reasonController = TextEditingController(text: widget.showCustomerForm.callReason);
    formI = widget.showCustomerForm.formName.toString();
    select = widget.showCustomerForm.howHeHearAboutUs.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_form,
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
          if (state is EditCustomerFormLoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return loadingDialog();
              },
            );
          }
          if (state is EditCustomerFormSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(50),
                content: Text("تم العدبل بنجاح"),
                backgroundColor: Colors.green,
              ),
            );
            nameController.clear();
            numberController.clear();
            occupationController.clear();
           // callerGovernorateController.clear();
            familyCountController.clear();
            reasonController.clear();
            areaController.clear();
            context.read<FormCubit>().getShowCustomer();
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            context.read<FormCubit>().getShowCustomer();
          }
          if (state is EditCustomerFormErrorState) {
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
          var centerResults = FormCubit.get(context).FormName2?.results;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                            keyboardType: TextInputType.text,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: nameController,
                            hintText: AppLocalizations.of(context)!
                                .caller_name,
                            svgPath: Assets.svgs.userRounded.path,
                            validator: (value) =>
                                Validator.validateNameController(
                                    value, state)),
                        CustomTextFormField(
                            keyboardType: TextInputType.number,
                            margin: const EdgeInsets.only(
                              top: Sizes.space12,
                              bottom: Sizes.space12,
                            ),
                            controller: numberController,
                            hintText: AppLocalizations.of(context)!
                                .caller_number,
                            svgPath: Assets.svgs.phone.path,
                            validator: (value) =>
                                Validator.validateNumberController(
                                    value, state)),
                        CustomTextFormField(
                            keyboardType: TextInputType.text,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: occupationController,
                            hintText: AppLocalizations.of(context)!
                                .caller_occupation,
                            svgPath:
                            Assets.svgs.jobLaptopSvgrepoCom.path,
                            validator: (value) =>
                                Validator.occupationController(
                                    value, state)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText:callerGovernorateController.text.isEmpty ?"المحافظة":callerGovernorateController.text,

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
                            value: dropdownValuepaymentType,
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
                            svgPath:
                            Assets.svgs.arrowleft.path,
                            validator: (value) =>
                                Validator.occupationController(
                                    value, state)),
                        CustomTextFormField(
                            keyboardType: TextInputType.number,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: familyCountController,
                            hintText: AppLocalizations.of(context)!
                                .family_members_count,
                            svgPath: Assets.svgs.familySvgrepoCom.path,
                            validator: (value) =>
                                Validator.familyCountController(
                                    value, state)),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: formI,
                            prefixIcon: Icon(
                              Icons.model_training,
                              color: ColorName.NuturalColor2,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorName.NuturalColor2), // Gray border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // Gray border when focused
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          value: formIdController,
                          onChanged: (newValue) {
                            setState(() {
                              formIdController = newValue;
                            });
                          },
                          items: centerResults?.map((result) {
                            return DropdownMenuItem<String>(
                              value: "${result.sId}", // Ensure value is unique
                              child: Text(
                                result.name ?? '',
                                style: const TextStyle(
                                  color: ColorName.NuturalColor5,
                                  fontSize: Sizes.fontLarge,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList().cast<DropdownMenuItem<String>>() ?? [],
                        ),


                        SizedBox(height: 8,),
                        CustomTextFormField(
                            keyboardType: TextInputType.number,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: areaController,
                            hintText: AppLocalizations.of(context)!
                                .required_area,
                            svgPath: Assets.svgs.vector
                                .path,
                            validator: (value) =>
                                Validator.reasonController(value, state)),
                        SizedBox(height: 4,),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: select,
                            prefixIcon: Icon(
                              Icons.social_distance,
                              color: ColorName.NuturalColor2,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorName.NuturalColor2), // Gray border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // Gray border when focused
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
                              value: "${result.name}", // Ensure value is unique
                              child: Text(
                                result.name ?? '',
                                style: const TextStyle(
                                  color: ColorName.NuturalColor5,
                                  fontSize: Sizes.fontLarge,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList().cast<DropdownMenuItem<String>>() ?? [],
                        ),

                        SizedBox(height: 4,),

                        CustomTextFormField(
                            keyboardType: TextInputType.text,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: reasonController,
                            maxLines: 4,
                            showMaxLength: true,
                            maxLength: 300,
                            hintText: AppLocalizations.of(context)!
                                .reason_for_contact,

                            validator: (value) =>
                                Validator.reasonController(value, state)),

                        SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              print(callerGovernorateController.text);
                              if (_formKey.currentState!.validate()) {
                                if(formIdController == null){
                                  formller =  widget.showCustomerForm.sId.toString();
                                }

                                if(selectedSource == null){
                                  Source =  widget.showCustomerForm.howHeHearAboutUs.toString();
                                }
                                FormCubit.get(context).editCustomerForm(
                                  caller_name: nameController.text,
                                  caller_phone: numberController.text,
                                  caller_job: occupationController.text,
                                  caller_governorate: callerGovernorateController.text,
                                  caller_address: addressController.text,
                                  family_members: int.parse(familyCountController.text),
                                  about_us: Source == null ? selectedSource!: Source!,
                                  space_required: int.parse(areaController.text),
                                  call_reason: reasonController.text,

                                  form_id: formller== null? formIdController!:formller!,

                                  idForm: "${widget.showCustomerForm.sId}",
                                );
                              }
                              if(state is EditCustomerFormSuccessState){

                              }
                            },
                            child: state is howHearLoadingState
                                ? CircularProgressIndicator()
                                : Text(
                              AppLocalizations.of(context)!.edit,
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
                          height: 20,
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
    );
  }
}






class Validator {
  static String? validateNameController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال اسم المتصل";
      }
      return null;
    }

    return null;
  }

  static String? validateNumberController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال رقم المتصل";
      }
      return null;
    }

    return null;
  }

  static String? occupationController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return null;
      }
      return null;
    }

    return null;
  }

  static String? addressController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال العنوان";
      }
      return null;
    }

    return null;
  }

  static String? familyCountController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخال عدد افراد الاسره";
      }
      return null;
    }

    return null;
  }

  static String? sourceController(
      String? value, FormAStates? state) {
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

  static String? reasonController(
      String? value, FormAStates? state) {
    if (state is CustomerFormErrorState) {
      if (value == null || value.isEmpty) {
        return "حقل مطلوب";
      }
      return null;
    }

    return null;
  }
}
