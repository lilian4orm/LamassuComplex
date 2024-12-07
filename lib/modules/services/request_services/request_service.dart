import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/models/services_model.dart';
import 'package:lamassu/modules/services/request_services/cubit/cubit.dart';
import 'package:lamassu/modules/services/request_services/cubit/state.dart';
import 'package:lamassu/shared/components/custom_textformfield.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:lamassu/shared/style/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key, required this.service});
  final ServicesResults service;

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
  String? dropdownValuePlace;
  String? dropdownValueService;
  TextEditingController notesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name;

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  void dispose() {
    notesController.dispose();
    dropdownValuePlace = null;
    dropdownValueService = null;
    super.dispose();
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
              widget.service.name!,
              style: const TextStyle(
                color: ColorName.NuturalColor5,
                fontSize: Sizes.fontLarge,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocProvider(
            create: (context) => ServiceCubit()..fetchBills(),
            child: BlocConsumer<ServiceCubit, ServiceState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ServiceLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ServiceSuccessState) {
                    return state.typeList.isEmpty || state.roomNameList.isEmpty
                        ? PlaceHolderWidget(
                            context: context,
                            title: 'لا يوجد بيانات',
                            image: Image.asset('asset/images/logo.png'))
                        : Container(
                            height: MediaQuery.of(context).size.height * .9,
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    dropDawnWidget(
                                        'اختر الموقع',
                                        state.roomNameList.map((e) {
                                          return '$e';
                                        }).toList(),
                                        2),
                                    dropDawnWidget(
                                        'اختر نوع الخدمة',
                                        state.typeList.map((e) {
                                          return '$e';
                                        }).toList(),
                                        3),
                                    CustomTextFormField(
                                      controller: notesController,
                                      hintText: 'وصف المشكلة',
                                      margin: EdgeInsets.all(16),
                                      maxLines: 5,
                                      maxLength: 200,
                                      showMaxLength: true,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MaterialButton(
                                          color: ColorName.bottomColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13, horizontal: 60),
                                          onPressed: () async {
                                            if (dropdownValuePlace != null &&
                                                dropdownValueService != null) {
                                              await ServiceCubit.get(context)
                                                  .postService({
                                                "name": name,
                                                "machine_name":
                                                    widget.service.name,
                                                'room_name': dropdownValuePlace,
                                                'fix_type':
                                                    dropdownValueService,
                                                'note': notesController.text,
                                                'service_id':
                                                    widget.service.sId,
                                              }, state.typeList,
                                                      state.roomNameList);
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'تم ارسال الطلب بنجاح'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'يرجى اختيار النوع والمكان والخدمة'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            'ارسال الطلب',
                                            style: TextStyle(
                                              color: ColorName.NuturalColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                  } else if (state is ServiceErrorState) {
                    return PlaceHolderWidget(
                        context: context,
                        title: state.message,
                        image: Image.asset('asset/images/logo.png'));
                  } else {
                    return Text('error');
                  }
                }),
          )),
    );
  }

  dropDawnWidget(String hint, List<String> items, int valueData) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: DropdownButtonFormField<String>(
          hint: Text(hint),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: ColorName.NuturalColor3,
            ),
            prefixIcon: Icon(
              Icons.merge_type,
              color: ColorName.NuturalColor3,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorName.NuturalColor2),
              // Gray border
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              // Gray border when focused
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          value: valueData == 2 ? dropdownValuePlace : dropdownValueService,
          onChanged: (newValue) {
            setState(() {
              if (valueData == 2) {
                dropdownValuePlace = newValue!;
              } else {
                dropdownValueService = newValue!;
              }
            });
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
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
    );
  }
}
