import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/apartment/apartment_tower_floor_model.dart';
import '../../../shared/components/Validatortext.dart';
import '../../../shared/components/custom_textformfield.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class RequestApprovedForm extends StatefulWidget {
  const RequestApprovedForm(
    this.name,
    this.phone,
    this.sidT,
  );

  final String? name;
  final String? phone;
  final String? sidT;

  @override
  State<RequestApprovedForm> createState() => _RequestApprovedFormState();
}

class _RequestApprovedFormState extends State<RequestApprovedForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();
  final customerPhoneTwoController = TextEditingController();
  final idNumberController = TextEditingController();
  final idIssueDateController = TextEditingController();
  final streetCountController = TextEditingController();

  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final houseController = TextEditingController();
  final emailController = TextEditingController();
  final familyNumberController = TextEditingController();
  final jobController = TextEditingController();
  final jobTypeController = TextEditingController();
  String? formIdController;

  String? houseIdController;
  String? TowersController;
  String? FloorsController;

  final priceController = TextEditingController();
  final accountNumberController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final priceWrittenController = TextEditingController();
  final managementFeesController = TextEditingController();
  final firstPaymentController = TextEditingController();
  final idFrontImageController = TextEditingController();
  final idBackImageController = TextEditingController();

  String? dropdownValue = 'اختر النوع:';
  String? dropdownValuejop = 'نوع العمل:';
  String? dropdownValuepaymentType = 'نوع الدفع:';

  Future<void> _getImage({required TextEditingController controller}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      final imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        controller.text = "data:image/png;base64,$base64Image";
      });
    }
  }

  Future<void> _takePhoto({required TextEditingController controller}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      final imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        controller.text = "data:image/png;base64,$base64Image";
      });
    }
  }

  List<dynamic>? houses;
  @override
  void initState() {
    accountNumberController.text = '53389';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reservation_form_apartment,
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
                content: Text("تم الارسال  بنجاح"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
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
          var Towers = FormCubit.get(context).Towers?.results;
          if (widget.name!.isNotEmpty) {
            customerNameController.text = widget.name!;
          }
          if (widget.phone!.isNotEmpty) {
            customerPhoneController.text = widget.phone!;
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        controller: idNumberController,
                        hintText:
                            AppLocalizations.of(context)!.national_id_number,
                        svgPath: Assets.svgs.form.userIdSvgrepoCom.path,
                        validator: (value) =>
                            Validator.reasonController7(value, state)),
                    SizedBox(
                      // width: MediaQuery.of(context).size.width / 2.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: ColorName.NuturalColor2)),
                          child: TextFormField(
                              controller: idIssueDateController,
                              style: TextStyle(
                                fontSize: Sizes.space16,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: ColorName.NuturalColor3,
                                ),
                                hintText: "تاريخ اصدار البطاقة",
                                hintStyle: TextStyle(
                                  color: ColorName.NuturalColor3,
                                ),
                              ),
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  locale: const Locale('en', 'US'),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime.now(),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData(
                                        colorScheme:
                                            ColorScheme.light().copyWith(),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (selectedDate != null) {
                                  idIssueDateController.text = selectedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                }
                              }),
                        ),
                      ),
                    ),
                    Wrap(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            margin: const EdgeInsets.only(
                              top: Sizes.space8,
                              bottom: Sizes.space8,
                            ),
                            controller: customerPhoneController,
                            hintText:
                                AppLocalizations.of(context)!.customer_phone,
                            svgPath: Assets.svgs.phone.path,
                            validator: (value) =>
                                Validator.validateNumberController(
                                    value, state)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          margin: const EdgeInsets.only(
                            top: Sizes.space8,
                            bottom: Sizes.space8,
                          ),
                          controller: customerPhoneTwoController,
                          hintText: "الهاتف الثاني",
                          svgPath: Assets.svgs.phone.path,
                          // validator: (value) =>
                          //     Validator.validateNumberController(
                          //         value, state)
                        ),
                      ),
                    ]),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: streetCountController,
                              hintText: AppLocalizations.of(context)!.address,
                              svgPath: Assets.svgs.form.streetSvgrepoCom.path,
                              validator: (value) =>
                                  Validator.reasonController6(value, state)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: cityController,
                              hintText:
                                  AppLocalizations.of(context)!.neighborhood,
                              svgPath: Assets.svgs.form.citySvgrepoCom.path,
                              validator: (value) =>
                                  Validator.reasonController11(value, state)),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: stateController,
                              hintText: AppLocalizations.of(context)!.alley,
                              svgPath: Assets.svgs.home2.path,
                              validator: (value) =>
                                  Validator.reasonController5(value, state)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: houseController,
                              hintText: AppLocalizations.of(context)!.house,
                              svgPath:
                                  Assets.svgs.form.houseWindowSvgrepoCom.path,
                              validator: (value) =>
                                  Validator.reasonController10(value, state)),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      margin: const EdgeInsets.only(
                        top: Sizes.space8,
                        bottom: Sizes.space8,
                      ),
                      controller: emailController,
                      hintText: AppLocalizations.of(context)!.email_optional,
                      svgPath: Assets.svgs.form.emailSvgrepoCom.path,
                    ),
                    CustomTextFormField(
                        keyboardType: TextInputType.number,
                        margin: const EdgeInsets.only(
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        controller: familyNumberController,
                        hintText:
                            AppLocalizations.of(context)!.family_members_count,
                        svgPath: Assets.svgs.form.familySvgrepoCom.path,
                        validator: (value) =>
                            Validator.reasonController9(value, state)),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: jobController,
                              hintText: 'الوظيفة',
                              svgPath:
                                  Assets.svgs.form.jobLaptopSvgrepoCom.path,
                              validator: (value) =>
                                  Validator.reasonController3(value, state)),
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
                                hintText: AppLocalizations.of(context)!
                                    .occupation_type,
                                prefixIcon: Icon(
                                  Icons.work,
                                  color: ColorName.NuturalColor2,
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
                              value: dropdownValuejop,
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValuejop = newValue!;
                                  jobTypeController.text = newValue;
                                });
                              },
                              items: <String>[
                                'نوع العمل:',
                                'حكومي',
                                'قطاع خاص'
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
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
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
                            child: FormCubit.get(context).Floors?.results ==
                                        null ||
                                    FormCubit.get(context)
                                        .Floors!
                                        .results!
                                        .isEmpty
                                ? const Text('لا يوجد طوابق')
                                : DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      hintText: "الطابق",
                                      helperStyle: TextStyle(
                                        color: ColorName.NuturalColor2,
                                      ),
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    value: FloorsController != null &&
                                            (FormCubit.get(context)
                                                        .Floors
                                                        ?.results ??
                                                    [])
                                                .any((house) =>
                                                    house.sId ==
                                                    FloorsController)
                                        ? FloorsController
                                        : null,
                                    onChanged: (newValue) {
                                      setState(() {
                                        FloorsController = newValue;
                                        FormCubit.get(context)
                                            .getApartmentTowerFloor(
                                                tower: TowersController,
                                                floor: newValue);

                                        houseIdController = null;
                                      });
                                    },
                                    items: (FormCubit.get(context)
                                                .Floors
                                                ?.results ??
                                            [])
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
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: (FormCubit.get(context)
                                                .ApartmentTowerFloor
                                                ?.results ??
                                            [])
                                        .where((house) =>
                                            house.status == 'غير محجوز')
                                        .toList()
                                        .length ==
                                    0
                                ? Center(
                                    child: const Text(
                                    'لا يوجد شقق',
                                    textAlign: TextAlign.center,
                                  ))
                                : DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      hintText:
                                          AppLocalizations.of(context)!.home,
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    value: houseIdController != null &&
                                            (FormCubit.get(context)
                                                        .ApartmentTowerFloor
                                                        ?.results ??
                                                    [])
                                                .any((house) =>
                                                    house.sId ==
                                                    houseIdController)
                                        ? houseIdController
                                        : null,
                                    onChanged: (newValue) {
                                      setState(() {
                                        houseIdController = newValue;
                                        formIdController =
                                            (FormCubit.get(context)
                                                        .ApartmentTowerFloor
                                                        ?.results ??
                                                    [])
                                                .firstWhere(
                                                    (house) =>
                                                        house.sId == newValue,
                                                    orElse: () => Results())
                                                .centerFormId;
                                      });
                                    },
                                    items: (FormCubit.get(context)
                                                .ApartmentTowerFloor
                                                ?.results ??
                                            [])
                                        .where((house) =>
                                            house.status == 'غير محجوز')
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
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: CustomTextFormField(
                              readonly: true,
                              keyboardType: TextInputType.text,
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              controller: accountNumberController,
                              hintText:
                                  AppLocalizations.of(context)!.account_number,
                              svgPath: Assets.svgs.userRounded2.path,
                              validator: (value) =>
                                  Validator.reasonController8(value, state)),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      margin: const EdgeInsets.only(
                        top: Sizes.space8,
                        bottom: Sizes.space8,
                      ),
                      controller: priceController,
                      addCommas: true,
                      hintText: "السعر رقما",
                      svgPath: Assets.svgs.form.priceTagSvgrepoCom.path,
                      validator: (value) =>
                          Validator.reasonController2(value, state),
                    ),
                    CustomTextFormField(
                        keyboardType: TextInputType.text,
                        margin: const EdgeInsets.only(
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        controller: priceWrittenController,
                        hintText: "السعر كتابة",
                        svgPath: Assets.svgs.form.paymentBitcoinSvgrepoCom.path,
                        validator: (value) =>
                            Validator.reasonController1(value, state)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.payment_type,
                          prefixIcon: Icon(
                            Icons.cached_outlined,
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
                        value: dropdownValuepaymentType,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValuepaymentType = newValue!;
                            paymentTypeController.text = newValue;
                          });
                        },
                        items: <String>['نوع الدفع:', 'نقد', 'دفعات']
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
                    CustomTextFormField(
                        keyboardType: TextInputType.number,
                        margin: const EdgeInsets.only(
                          top: Sizes.space8,
                          bottom: Sizes.space8,
                        ),
                        controller: managementFeesController,
                        addCommas: true,
                        hintText:
                            AppLocalizations.of(context)!.administrative_fees,
                        svgPath: Assets.svgs.form.priceTagSvgrepoCom.path,
                        validator: (value) =>
                            Validator.reasonController(value, state)),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      margin: const EdgeInsets.only(
                        top: Sizes.space8,
                        bottom: Sizes.space8,
                      ),
                      controller: firstPaymentController,
                      addCommas: true,
                      hintText: paymentTypeController.text == "نقد"
                          ? priceController.text
                          : AppLocalizations.of(context)!.down_payment,
                      svgPath: Assets.svgs.form.accountBoxSvgrepoCom.path,
                      onChanged: (text) {
                        // Add any additional onChanged logic if needed
                      },
                      validator: (value) => paymentTypeController.text == "نقد"
                          ? null
                          : Validator.occupationController(
                              value, priceController, state),
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return BottomSheet(
                                    backgroundColor: ColorName.brandPrimary,
                                    onClosing: () {},
                                    builder: (context) {
                                      return Container(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                              leading:
                                                  Icon(Icons.photo_library),
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .gallery),
                                              onTap: () async {
                                                await _getImage(
                                                  controller:
                                                      idFrontImageController,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_camera),
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .camera),
                                              onTap: () async {
                                                await _takePhoto(
                                                  controller:
                                                      idFrontImageController,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorName.brandPrimary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgs.form.userIdSvgrepoCom.path,
                                    width: 100,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8),
                                  Text(AppLocalizations.of(context)!
                                      .front_id_image),
                                  if (idFrontImageController.text.isNotEmpty)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            idFrontImageController.clear();
                                          });
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.remove,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return BottomSheet(
                                    backgroundColor: ColorName.brandPrimary,
                                    onClosing: () {},
                                    builder: (context) {
                                      return Container(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                              leading:
                                                  Icon(Icons.photo_library),
                                              title: Text('معرض الصور'),
                                              onTap: () async {
                                                await _getImage(
                                                  controller:
                                                      idBackImageController,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_camera),
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .camera),
                                              onTap: () async {
                                                await _takePhoto(
                                                  controller:
                                                      idBackImageController,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: const EdgeInsets.only(
                                top: Sizes.space8,
                                bottom: Sizes.space8,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorName.brandPrimary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgs.form.userIdSvgrepoCom.path,
                                    width: 100,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8),
                                  Text(AppLocalizations.of(context)!
                                      .back_id_image),
                                  if (idBackImageController.text.isNotEmpty)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            idBackImageController.clear();
                                          });
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.remove,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (paymentTypeController.text == "نقد" &&
                              firstPaymentController.text.isEmpty) {
                            firstPaymentController.text = priceController.text;
                          }

                          if (_formKey.currentState!.validate()) {
                            FormCubit.get(context).postApplicationForm(
                              customer_name: customerNameController.text,
                              customer_phone: customerPhoneController.text,
                              customer_phone_two:
                                  customerPhoneTwoController.text,
                              id_number: idNumberController.text,
                              id_issue_date: idIssueDateController.text,
                              street: streetCountController.text,
                              state: stateController.text,
                              city: cityController.text,
                              house: houseController.text,
                              email: emailController.text,
                              family_number:
                                  int.parse(familyNumberController.text),
                              job: jobController.text,
                              job_type: jobTypeController.text,
                              form_id: formIdController!,
                              house_id: houseIdController!,
                              price: int.tryParse(
                                priceController.text.replaceAll(',', ''),
                              )!,
                              account_number: accountNumberController.text,
                              payment_type: paymentTypeController.text,
                              price_written: priceWrittenController.text,
                              management_fees: int.tryParse(
                                managementFeesController.text
                                    .replaceAll(',', ''),
                              )!,
                              first_payment: int.tryParse(
                                firstPaymentController.text.replaceAll(',', ''),
                              )!,
                              id_front_image: idFrontImageController.text,
                              id_back_image: idBackImageController.text,
                            );
                            if (widget.sidT != null) {
                              if (state is CustomerFormSuccessState) {
                                FormCubit.get(context)
                                    .putTransferred(sid: widget.sidT);
                                print("putTransferred(sid: widget.sidT");
                              }
                            }
                          }
                        },
                        child: state is CustomerFormLoadingState
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
                      height: 16,
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
