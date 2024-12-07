import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/notifications_model.dart';
import '../../../shared/components/communicate.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationData notification;

  const NotificationItemWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSheet(
          context: context,
          title: notification.title ?? '',
          body: notification.body ?? '',
          image: imageStorg + (notification.image ?? 'asset/logo.jpg'),
          link: notification.link != null
              ? () {
                  openUrl(notification.link.toString());
                }
              : null,
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          imageStorg + (notification.image ?? 'asset/logo.jpg'),
                      height: MediaQuery.of(context).size.height * .07,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          height: 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'asset/logo.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                notification.title!,
                                style: const TextStyle(
                                  color: ColorName.NuturalColor5,
                                  fontSize: Sizes.fontDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              _formatDate(notification.createdAt!),
                              style: const TextStyle(
                                color: ColorName.NuturalColor3,
                                fontSize: Sizes.fontSmall,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          notification.body!,
                          style: const TextStyle(
                            color: ColorName.NuturalColor4,
                            fontSize: Sizes.fontDefault,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: ColorName.NuturalColor2,
          )
        ],
      ),
    );
  }

  String _formatDate(String date) {
    return DateFormat('yyyy.MM.dd').format(DateTime.parse(date));
  }

  void showSheet(
      {required BuildContext context,
      required String title,
      required String body,
      required String? image,
      VoidCallback? link}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorName.secondaryLight,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorName.NuturalColor3),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image!,
                      //height: MediaQuery.of(context).size.height * .2,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => Image.asset(
                          'asset/logo.jpg',
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                const Divider(color: ColorName.NuturalColor2),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: ColorName.NuturalColor5,
                          fontSize: Sizes.fontDefault,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (link != null)
                      InkWell(
                        onTap: link,
                        child: Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorName.successColor2),
                          child: Center(
                              child: Assets.svgs.link.svg(
                                  color: ColorName.NuturalColor5, width: 30)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  body,
                  style: const TextStyle(
                    color: ColorName.NuturalColor4,
                    fontSize: Sizes.fontDefault,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
