import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../models/show_apply_form_model.dart';

import '../../../../shared/style/colors.dart';
import '../../../../shared/style/sizes.dart';




class ShowDataApplyForm extends StatefulWidget {
  const ShowDataApplyForm({Key? key, required this.showApplyForm}) : super(key: key);
  final Data showApplyForm;

  @override
  State<ShowDataApplyForm> createState() => _ShowDataApplyFormState();
}

class _ShowDataApplyFormState extends State<ShowDataApplyForm> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.showApplyForm.customerName}",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(widget.showApplyForm.customerName != null)
            buildPadding(title: AppLocalizations.of(context)!.name, disc: "${widget.showApplyForm.customerName}"),
            if(widget.showApplyForm.customerPhone != null)
              buildPadding(title: AppLocalizations.of(context)!.phone_number, disc: "${widget.showApplyForm.customerPhone}"),
            if(widget.showApplyForm.formName != null)
            buildPadding(title: AppLocalizations.of(context)!.form_name, disc: "${widget.showApplyForm.formName}"),
            if(widget.showApplyForm.houseName != null)
            buildPadding(title: AppLocalizations.of(context)!.house_name, disc: "${widget.showApplyForm.houseName}"),
          //  buildPadding(title: AppLocalizations.of(context)!.total_area, disc: "${widget.showApplyForm.formTotalSpace}"),
          //  buildPadding(title: AppLocalizations.of(context)!.building_space, disc: "${widget.showApplyForm.formBuildingSpace}"),
            buildPadding(title: AppLocalizations.of(context)!.date, disc: "${widget.showApplyForm.createdAt}"),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorName.secondaryLight,
              border: Border.all(
                  width: 1,
                  color: ColorName.NuturalColor1
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: Offset(0, 2), // Offset from top left
                ),
              ],

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.details,
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Text(
                      "${widget.showApplyForm.details}",
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w400,

                      ),
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
            SizedBox(height: 32,),


          ],
        ),

      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Icon(Icons.share),
      // ),
    );
  }





  Widget buildPadding(

      {
    required String? title,
    required String? disc,
}) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorName.secondaryLight,
              border: Border.all(
                width: 1,
                color: ColorName.NuturalColor1
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: Offset(0, 2), // Offset from top left
                ),
              ],

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          title!,
                          style: const TextStyle(
                            color: ColorName.NuturalColor5,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 20,
                      width: 1,
                      color: ColorName.NuturalColor3,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      disc!,
                      style: const TextStyle(
                        color: ColorName.NuturalColor3,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w400,
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






