import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamassu/modules/home/cubit/cubit.dart';
import 'package:lamassu/modules/home/cubit/state.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/components/custom_textformfield.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class BookedHouse extends StatefulWidget {
  const BookedHouse({Key? key, required this.houseId}) : super(key: key);
  final String houseId;

  @override
  State<BookedHouse> createState() => _BookedHouseState();
}

class _BookedHouseState extends State<BookedHouse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.booking_details,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) => HomeCubit(),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is HomeGetReservationsLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return loadingDialog();
                },
              );
            } else if (state is HomeGetReservationsSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "تم الحجز بنجاح سيتم التواصل معك من قبل موظف المبيعات"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is HomeGetReservationsErrorState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("خطا في الحجز"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.thank_you,
                            style: const TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .provide_info_for_confirmation,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: ColorName.NuturalColor4,
                              fontSize: Sizes.fontDefault,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                          keyboardType: TextInputType.text,
                          margin: const EdgeInsets.only(
                            top: Sizes.space32,
                            bottom: Sizes.space12,
                          ),
                          controller: userController,
                          hintText: AppLocalizations.of(context)!.caller_name,
                          svgPath: Assets.svgs.userRounded.path,
                          validator: (value) =>
                              Validator.validateName(value, state)),
                      CustomTextFormField(
                        keyboardType: TextInputType.phone,
                        margin: const EdgeInsets.only(
                          bottom: Sizes.space12,
                        ),
                        controller: phoneController,
                        hintText: AppLocalizations.of(context)!.phone_number,
                        svgPath: Assets.svgs.phone.path,
                        showMaxLength: true,
                        maxLength: 11,
                        validator: (value) =>
                            Validator.validatePhoneNumber(value, state),
                      ),
                      CustomTextFormField(
                          keyboardType: TextInputType.text,
                          margin: const EdgeInsets.only(
                            bottom: Sizes.space32,
                          ),
                          controller: locationController,
                          hintText: "اكتب تاريخ ويوم الحجز",
                          svgPath: Assets.svgs.mapWave.path,
                          validator: (value) =>
                              Validator.validateAdress(value, state)),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (phoneController.text.length > 11 ||
                                phoneController.text.length < 11) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "يرجى إدخال رقم هاتف صحيح مكون من 11 رقم"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (_formKey.currentState!.validate()) {
                              HomeCubit.get(context).postReservations(
                                userController.text,
                                phoneController.text,
                                locationController.text,
                                widget.houseId,
                              );
                            }
                          }
                        },
                        child: state is HomeGetReservationsLoadingState
                            ? CircularProgressIndicator()
                            : Text(
                                AppLocalizations.of(context)!.book_now,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: ColorName.secondaryLight,
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
  static String? validatePhoneNumber(String? value, HomeStates? state) {
    if (state is HomeGetReservationsErrorState) {
      if (value!.length != 11 || !RegExp(r'^[0-9]{11}$').hasMatch(value)) {
        return "يرجى إدخال رقم هاتف صحيح مكون من 11 رقم";
      }
    }

    return null;
  }

  static String? validateName(String? value, HomeStates? state) {
    if (state is HomeGetReservationsErrorState) {
      if (value == null || value.isEmpty) {
        return "يرجا ادخل اسمك";
      }
      return null;
    }

    return null;
  }

  static String? validateAdress(String? value, HomeStates? state) {
    if (state is HomeGetReservationsErrorState) {
      if (value == null || value.isEmpty) {
        return "يتطلب عنوان السكن";
      }
      return null;
    }

    return null;
  }
}
