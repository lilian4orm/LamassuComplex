import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/form/widget/show_form/show_data_apply_form.dart';
import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowApplyForm extends StatefulWidget {
  const ShowApplyForm({Key? key});

  @override
  State<ShowApplyForm> createState() => _ShowCustomerFormState();
}

class _ShowCustomerFormState extends State<ShowApplyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.requests,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => FormCubit()..getShowShowApply(),
        child: BlocConsumer<FormCubit, FormAStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ShowApplyFormsSuccessState) {
              final showCustomer = state.ShowApply!;
              if (showCustomer.results!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: showCustomer.results!.data!.length,
                  itemBuilder: (context, index) {
                    final data = showCustomer.results!.data![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorName.NuturalColor2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.customerName ?? '',
                                      style: const TextStyle(
                                        color: ColorName.NuturalColor5,
                                        fontSize: Sizes.fontLarge,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      data.customerPhone ?? '',
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
                                flex: 1,
                                child: Text(
                                  data.createdAt ?? '',
                                  style: const TextStyle(
                                    color: ColorName.NuturalColor3,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowDataApplyForm(
                                          showApplyForm: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12)),
                                      color: ColorName.brandPrimary,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.show_chart,
                                          color: ColorName.secondaryLight,
                                          size: 30,
                                        ),
                                        Text(
                                          'عرض',
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
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "لاتوجد طلبات",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else if (state is ShowCustomerFormsErrorState) {
              return Center(
                child: Text(
                  "لاتوجد طلبات",
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
