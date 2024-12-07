import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/assets.gen.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widget/widget_notification.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(_onScroll);
    context.read<NotificationCubit>().getNotification();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<NotificationCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NotificationCubit, NotificationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NotificationGetNotificationLoadingState) {
            return ShimmerNotification(context);
          } else if (state is NotificationGetNotificationSuccessState && context.read<NotificationCubit>().notifications.isNotEmpty) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.notification.length + (context.read<NotificationCubit>().hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.notification.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var notification = state.notification[index];
                return NotificationItemWidget(notification: notification);
              },
            );
          } else if (state is NotificationGetNotificationErrorState) {
            return PlaceHolderWidget(
              context: context,
              title: AppLocalizations.of(context)!.there_are_no_notifications_currently,
              image: Assets.illustrations.notifplas.svg(),
            );
          } else {
            return PlaceHolderWidget(
              context: context,
              title: AppLocalizations.of(context)!.there_are_no_notifications_currently,
              image: Assets.illustrations.notifplas.svg(),
            );
          }
        },
      ),
    );
  }

  Widget ShimmerNotification(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipOval(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.height * .07,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey[300],
                                    ),
                                    height: 20,
                                    width: 150,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 50,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 20,
                                width: double.infinity,
                                color: Colors.grey[300],
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
                  color: Colors.grey[300],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

