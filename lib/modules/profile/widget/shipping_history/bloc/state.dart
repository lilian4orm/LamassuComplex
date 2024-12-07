import 'package:lamassu/modules/profile/widget/shipping_history/models/shipping_model.dart';

abstract class LogStates {}

class LogInitialState extends LogStates {}

class ShippingLoadingState extends LogStates {}

class ShippingSuccessState extends LogStates {
  final List<ShipingResponeModel> logList;

  ShippingSuccessState(this.logList);
}

class ShippingErrorState extends LogStates {
  final String error;

  ShippingErrorState(this.error);
}

class ServiceLoadingState extends LogStates {}

class ServiceSuccessState extends LogStates {
  final List<ShipingResponeModel> logList;

  ServiceSuccessState(this.logList);
}

class ServiceErrorState extends LogStates {
  final String error;

  ServiceErrorState(this.error);
}
