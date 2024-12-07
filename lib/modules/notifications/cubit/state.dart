import '../../../models/notifications_model.dart';

abstract class NotificationStates {}

class NotificationInitialState extends NotificationStates {}

class NotificationGetNotificationLoadingState extends NotificationStates {}

class NotificationGetNotificationSuccessState extends NotificationStates {
  final List<NotificationData> notification;

  NotificationGetNotificationSuccessState(this.notification);
}

class NotificationGetNotificationErrorState extends NotificationStates {
  final String error;

  NotificationGetNotificationErrorState(this.error);
}

class NotificationLoadMoreState extends NotificationStates {
}





