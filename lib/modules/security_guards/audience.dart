import 'package:flutter/material.dart';

import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';

class AudienceScreen extends StatelessWidget {
  const AudienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         "الحضور",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorName.successColor3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "حضور",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "2024.3.11",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorName.errorColor3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "غياب",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "2024.3.11",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorName.warningColor3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "اجازه",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "2024.3.11",
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
