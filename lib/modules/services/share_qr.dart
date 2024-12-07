import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart' as Share;
import '../../models/qr_generate_model.dart';
import '../../shared/components/loading.dart';
import '../../shared/style/colors.dart';

import 'package:path/path.dart' as join;
import 'package:path_provider/path_provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

Widget shareQrAlertDialog(
  BuildContext context,
  String name,
) {
  return BlocProvider(
    create: (context) => ServicesCubit()..QrGenerateGet(),
    child: BlocConsumer<ServicesCubit, ServicesStates>(
      listener: (context, state) {
        if (state is QrGenerateGetErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("يوجد خطا اعد المحاولة لاحقا"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is QrGenerateGetLoadingState) {
          return loadingDialog();
        } else if (state is QrGenerateGetSuccessState) {
          return AlertDialog(
            backgroundColor: ColorName.secondaryLight,
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.share_qr,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorName.NuturalColor6,
                  ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              AppLocalizations.of(context)!.unique_qr_code,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorName.NuturalColor3,
                  ),
              textAlign: TextAlign.start,
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    ColorName.NuturalColor6,
                  ),
                ),
                onPressed: () async {
                  final imageFile = await _getImageFile(
                      context, context.read<ServicesCubit>().qrGenerate!);
                  if (imageFile != null) {
                    final Uint8List bytes = await imageFile.readAsBytes();
                    await Share.Share.file(
                      'ملف الصورة',
                      'qr_code.png',
                      bytes,
                      'image/png',
                      text:
                          " تفضل بدعوتك من ${name.toString()} للزيارة إلى مجمع الروان! نحن نرحب بك للتمتع بتجربة فريدة ومميزة. احتفظ بهذه الرسالة كدعوة للدخول  هذا Qr فعال لمدة ساعة واحدة و دخول مره واحدة فقط.",
                    );
                  } else {}
                },
                child: Text(
                  AppLocalizations.of(context)!.share,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: ColorName.secondaryLight,
                      ),
                ),
              ),
            ],
          );
        } else {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("يوجد خطا اعد المحاولة لاحقا"),
              ],
            ),
          );
        }
      },
    ),
  );
}

Future<File?> _getImageFile(BuildContext context, QrGenerate qrImage) async {
  final imageUrl = qrImage.contentUrl! + qrImage.results!;

  try {
    final response = await Dio().get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File(join.join(directory.path, 'qr_code.png'));
    await imageFile.writeAsBytes(response.data!);

    return imageFile;
  } catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("يوجد خطا اعد المحاولة لاحقا"),
        backgroundColor: Colors.red,
      ),
    );
    print("Error: Failed to load image from the network");
    return null;
  }
}
