import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/notifications_model.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/remote/dio_helper.dart';
import 'state.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);

  List<NotificationData> notifications = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  void getNotification() async {
    if (notifications.isNotEmpty) {
      emit(NotificationGetNotificationSuccessState(notifications));
      return;
    }
    emit(NotificationGetNotificationLoadingState());
    await _fetchNotifications(page: 1, isInitialLoad: true);
  }

  void loadMore() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    currentPage++;
    await _fetchNotifications(page: currentPage, isInitialLoad: false);
    isLoadingMore = false;
  }

  Future<void> _fetchNotifications(
      {required int page, required bool isInitialLoad}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? owner = prefs.getString('owner');
    String? sells_emp = prefs.getString('sells_emp');
    var headers = {'center_id': CanterId, "Authorization": token};

    try {
      var response = await performRequest(
          'GET',
          owner != null
              ? 'owner/notifications?page=$page&limit=10'
              : sells_emp != null
                  ? 'sellsEmployee/notifications?page=$page&limit=10'
                  : 'notifications?page=$page&limit=10',
          headers);
      if (response.statusCode == 200) {
        NotificationResults notificationResults =
            NotificationResults.fromJson(response.data['results']);

        if (isInitialLoad) {
          notifications = notificationResults.data!;
        } else {
          notifications.addAll(notificationResults.data!);
        }

        if (notificationResults.data!.length < 10) {
          hasMore = false;
        }
        emit(NotificationGetNotificationSuccessState(notifications));
      } else {
        emit(NotificationGetNotificationErrorState(
            response.statusMessage ?? 'Error'));
      }
    } catch (e) {
      emit(NotificationGetNotificationErrorState('Error: $e'));
      print("Error45678: $e");
    }
  }
}
