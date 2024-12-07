import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lamassu/modules/about_complex/cubit/cubit.dart';
import 'package:lamassu/modules/about_complex/cubit/state.dart';
import 'package:lamassu/modules/about_complex/widget/about_complexity.dart';
import 'package:lamassu/modules/about_complex/widget/hous_disgin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/components/no_internet.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';

class AboutTheComplex extends StatefulWidget {
  const AboutTheComplex({super.key});

  @override
  State<AboutTheComplex> createState() => _AboutTheComplexState();
}

class _AboutTheComplexState extends State<AboutTheComplex> {
  String? owner;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    owner = prefs.getString('owner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.about_the_complex,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<CenterCubit, CenterStates>(
        listener: (context, state) {
          if (state is CenterGetcenterSuccessState) {
            // إضافة أي تعليمات استماع إضافية هنا
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is CenterGetcenterLoadingState ||
                      state is FormNameLoadingState)
                    Center(child: CircularProgressIndicator()),
                  if (state is CenterGetcenterErrorState ||
                      state is FormNameErrorState)
                    Center(
                      child: noInternet(
                        context: context,
                        onTap: () {
                          context.read<CenterCubit>()..getCenterReseid();
                          context.read<CenterCubit>()..getFormName();
                        },
                      ),
                    ),
                  if (state is CenterGetcenterSuccessState ||
                      CenterCubit.get(context).center != null)
                    aboutComplexity(CenterCubit.get(context).center!),
                  if (state is FormNameSuccessState ||
                      CenterCubit.get(context).FormName != null)
                    if (owner == null)
                      modelsHous(context, CenterCubit.get(context).FormName)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
