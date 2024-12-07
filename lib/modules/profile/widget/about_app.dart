import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamassu/gen/assets.gen.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';

import '../../../models/about_app_model.dart';
import '../../../shared/components/communicate.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key, required this.cubit}) : super(key: key);
  final AboutAppModel? cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${cubit!.results!.name}",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: cubit!.results != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: cubit!.results!.logo == null
                            ? Assets.images.logo.image()
                            : CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl:
                                    imageStorg + "${cubit!.results!.logo}",
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Assets.images.logo.image(),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cubit!.results!.name}: ",
                            style: const TextStyle(
                              color: ColorName.NuturalColor5,
                              fontSize: Sizes.fontLarge,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "${cubit!.results!.description}",
                              style: const TextStyle(
                                color: ColorName.NuturalColor5,
                                fontSize: Sizes.fontDefault,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    cubit!.results!.address!.isNotEmpty
                        ? const Divider(
                            color: ColorName.NuturalColor5,
                            thickness: 1,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "العنوان: ",
                                  style: const TextStyle(
                                    color: ColorName.NuturalColor5,
                                    fontSize: Sizes.fontLarge,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${cubit!.results!.address}",
                                  style: const TextStyle(
                                    color: ColorName.NuturalColor5,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          if (cubit!.results!.phone!.isNotEmpty)
                            _buildSocialMediaItem(
                              title: "اتصال هاتفي",
                              iconPath: "asset/svgs/phonecall.svg",
                              onTap: () {
                                launchPhoneCall(cubit!.results!.phone!);
                              },
                            ),
                          if (cubit!.results!.website!.isNotEmpty)
                            _buildSocialMediaItem(
                              title: "زيارة الموقع",
                              iconPath: "asset/svgs/form/web.svg",
                              onTap: () {
                                launchWhatsApp(cubit!.results!.website!);
                              },
                            ),
                          if (cubit!.results!.facebook!.isNotEmpty)
                            _buildSocialMediaItem(
                              title: "فيسبوك",
                              iconPath: Assets.svgs.frameb.path,
                              onTap: () {
                                openUrl(cubit!.results!.facebook!);
                              },
                            ),
                          if (cubit!.results!.instagram!.isNotEmpty)
                            _buildSocialMediaItem(
                              title: "انستغرام",
                              iconPath: Assets.svgs.framea.path,
                              onTap: () {
                                openUrl(cubit!.results!.instagram!);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : PlaceHolderWidget(
              context: context,
              title: "لاتوجد بيانات",
              image: Assets.illustrations.complex.svg()),
    );
  }

  Widget _buildSocialMediaItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
            color: ColorName.NuturalColor1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: ColorName.NuturalColor5,
                    fontSize: Sizes.fontLarge,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorName.secondaryLight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(child: SvgPicture.asset(iconPath, height: 60)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
