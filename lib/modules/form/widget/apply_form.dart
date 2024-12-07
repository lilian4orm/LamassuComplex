import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../gen/assets.gen.dart';

import '../../../../shared/components/custom_textformfield.dart';
import '../../../../shared/components/loading.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

import '../../../models/apartment/apartment_tower_floor_model.dart' as resl;


class ApplyFormScreen extends StatefulWidget {
  const ApplyFormScreen({Key? key}) : super(key: key);

  @override
  State<ApplyFormScreen> createState() => _ApplyFormScreenState();
}

class _ApplyFormScreenState extends State<ApplyFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();
  String? formIdController;
  String? houseIdController;
  String? TowersController;
  String? FloorsController;
  final detailsController = TextEditingController();
  final typeController = TextEditingController();

  List<dynamic>? houses;

  String? dropdownValueType;

  @override
  void initState() {
    super.initState();
    dropdownValueType = 'اختر النوع:';
    // Fetch the data
    // FormCubit.get(context).howHearAboutUs();
    // FormCubit.get(context).getCenterForms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          var Towers = FormCubit.get(context).Towers?.results;


          return SingleChildScrollView(
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
                        controller: customerNameController,
                        hintText: AppLocalizations.of(context)!.customer_name,
                        svgPath: Assets.svgs.userRounded.path,
                        validator: (value) =>
                            Validator.validateNameController(value, state)),
                    CustomTextFormField(
                        keyboardType: TextInputType.number,
                        margin: const EdgeInsets.only(
                          top: Sizes.space12,
                          bottom: Sizes.space12,
                        ),
                        maxLength: 11,
                        showMaxLength: true,
                        maxLines: 1,
                        controller: customerPhoneController,
                        hintText: AppLocalizations.of(context)!.customer_phone,
                        svgPath: Assets.svgs.phone.path,
                        validator: (value) =>
                            Validator.validateNumberController(value, state)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.type,
                            prefixIcon: Icon(
                              Icons.merge_type,
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
                          value: dropdownValueType,
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValueType = newValue!;
                              typeController.text = newValue;
                            });
                          },
                          items: <String>['اختر النوع:', 'ايجار', 'بيع']
                              .map<DropdownMenuItem<String>>((String value) {
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
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: "العمارة",
                                prefixIcon: Icon(
                                  Icons.model_training,
                                  color: ColorName.NuturalColor2,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorName.NuturalColor2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              value: TowersController != null &&
                                  Towers?.any((result) =>
                                  result.exactApartmentBuilding ==
                                      TowersController) ==
                                      true
                                  ? TowersController
                                  : null,
                              onChanged: (newValue) {
                                setState(() {
                                  TowersController = newValue;
                                  FormCubit.get(context)
                                      .getFloors(id: newValue!);
                                  FloorsController = null;
                                });
                              },
                              items: Towers?.map((result) {
                                return DropdownMenuItem<String>(
                                  value: result.exactApartmentBuilding!,
                                  child: Text(
                                    result.exactApartmentBuilding ?? '',
                                    style: const TextStyle(
                                      color: ColorName.NuturalColor5,
                                      fontSize: Sizes.fontLarge,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList() ??
                                  [],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: "الطابق",
                                prefixIcon: Icon(
                                  Icons.house,
                                  color: ColorName.NuturalColor2,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorName.NuturalColor2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              value: FloorsController != null &&
                                  (FormCubit.get(context).Floors?.results ??
                                      [])
                                      .any((house) =>
                                  house.sId == FloorsController)
                                  ? FloorsController
                                  : null,
                              onChanged: (newValue) {
                                setState(() {
                                  FloorsController = newValue;
                                  FormCubit.get(context).getApartmentTowerFloor(
                                      tower: TowersController, floor: newValue);
                                  print(TowersController.toString());
                                  print(newValue);
                                  houseIdController = null;
                                });
                              },
                              items:
                              (FormCubit.get(context).Floors?.results ?? [])
                                  .map((house) {
                                return DropdownMenuItem<String>(
                                  value: house.apartmentFloorNumber!,
                                  child: Text(
                                    house.apartmentFloorNumber ?? '',
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
                      ],
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.home,
                                prefixIcon: Icon(
                                  Icons.house,
                                  color: ColorName.NuturalColor2,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: ColorName.NuturalColor2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              value: houseIdController != null &&
                                  (FormCubit.get(context)
                                      .ApartmentTowerFloor
                                      ?.results ??
                                      [])
                                      .any((house) =>
                                  house.sId == houseIdController)
                                  ? houseIdController
                                  : null,
                              onChanged: (newValue) {
                                setState(() {
                                  houseIdController = newValue;
                                  formIdController = (FormCubit.get(context)
                                      .ApartmentTowerFloor
                                      ?.results ??
                                      [])
                                      .firstWhere((house) => house.sId == newValue,
                                      orElse: () => resl.Results())
                                      .centerFormId;

                                  print(formIdController);
                                  print(formIdController);
                                  print(formIdController);
                                });
                              },
                              items: (FormCubit.get(context)
                                  .ApartmentTowerFloor
                                  ?.results ??
                                  [])
                                  .where((house) => house.status == 'غير محجوز')
                                  .map((house) {
                                return DropdownMenuItem<String>(
                                  value: house.sId!,
                                  child: Text(
                                    house.name ?? '',
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


                      ],
                    ),
                    CustomTextFormField(
                        keyboardType: TextInputType.text,
                        margin: const EdgeInsets.only(
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        maxLines: 6,
                        maxLength: 300,
                        showMaxLength: true,
                        controller: detailsController,
                        hintText: AppLocalizations.of(context)!.details,
                        validator: (value) =>
                            Validator.familyCountController(value, state)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FormCubit.get(context).postApplyForm(
                              customer_name: customerNameController.text,
                              customer_phone: customerPhoneController.text,
                              form_id: formIdController!,
                              house_id: houseIdController!,
                              details: detailsController.text,
                              type: typeController.text,
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
