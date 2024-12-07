import 'package:flutter/material.dart';
import 'package:lamassu/shared/components/custom_textformfield.dart';
import 'package:lamassu/shared/style/colors.dart';

class RequestShippingScreen extends StatefulWidget {
  const RequestShippingScreen(
      {super.key, required this.note, required this.onTap});
  final TextEditingController note;
  final void Function() onTap;

  @override
  State<RequestShippingScreen> createState() => _RequestShippingScreenState();
}

class _RequestShippingScreenState extends State<RequestShippingScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorName.NuturalColor1,
        appBar: AppBar(
          title: Text('شحن الخدمات'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              CustomTextFormField(
                controller: widget.note,
                hintText: 'اذكر التفاصيل الموقع داخل المنزل ماذا تحتاج ... الخ',
                maxLines: 5,
                keyboardType: TextInputType.text,
                maxLength: 200,
                showMaxLength: true,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorName.NuturalColor6,
                  maximumSize: Size(MediaQuery.of(context).size.width * .7, 50),
                ),
                onPressed: () {
                  widget.onTap();
                },
                child: Text(
                  'اطلب الخدمة',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: ColorName.secondaryLight,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
