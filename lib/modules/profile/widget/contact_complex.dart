import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/components/communicate.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../../about_complex/cubit/cubit.dart';
import '../../about_complex/cubit/state.dart';

class SocialCommunication extends StatefulWidget {
  const SocialCommunication({super.key});

  @override
  State<SocialCommunication> createState() => _SocialCommunicationState();
}

class _SocialCommunicationState extends State<SocialCommunication> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CenterCubit, CenterStates>(
      listener: (context, state) {
        if (state is CenterGetcenterSuccessState) {}
      },
      builder: (context, state) {
        var complex = CenterCubit.get(context).center;
        if (state is CenterGetcenterSuccessState || complex != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.community_engagement,
                style: const TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontLarge,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: complex!.logo == null
                            ? Assets.images.logo.image()
                            : CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl: imageStorg + "${complex.logo}",
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          if (complex.phone != null)
                            _buildSocialMediaItem(
                              title: "الاتصال بالمجمع",
                              iconPath: "asset/svgs/phonecall.svg",
                              onTap: () {
                                launchPhoneCall(complex.phone!);
                              },
                            ),
                          if (complex.whatsapp != null)
                            _buildSocialMediaItem(
                              title: "الواتساب",
                              iconPath: "asset/svgs/whatsap.svg",
                              onTap: () {
                                launchWhatsApp(complex.whatsapp!);
                              },
                            ),
                          if (complex.facebook != null)
                            _buildSocialMediaItem(
                              title: "فيسبوك",
                              iconPath: Assets.svgs.frameb.path,
                              onTap: () {
                                openUrl(complex.facebook!);
                              },
                            ),
                          if (complex.instagram != null)
                            _buildSocialMediaItem(
                              title: "إنستجرام",
                              iconPath: Assets.svgs.framea.path,
                              onTap: () {
                                openUrl(complex.instagram!);
                              },
                            ),
                          if (complex.snapchat != null)
                            _buildSocialMediaItem(
                              title: "سناب شات",
                              iconPath: Assets.svgs.framead.path,
                              onTap: () {
                                openUrl(complex.snapchat!);
                              },
                            ),
                          if (complex.tiktok != null)
                            _buildSocialMediaItem(
                              title: "تيك توك",
                              iconPath: Assets.svgs.frameac.path,
                              onTap: () {
                                openUrl(complex.tiktok!);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is CenterGetcenterLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
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
