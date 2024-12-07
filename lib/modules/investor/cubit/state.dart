import 'package:lamassu/modules/investor/models/hoses_report_model.dart';
import 'package:lamassu/modules/investor/models/money_houses_model.dart';
import 'package:lamassu/modules/investor/models/security_clean_model.dart';
import 'package:lamassu/modules/investor/models/service_model.dart';
import 'package:lamassu/modules/investor/models/service_request_model.dart';

abstract class ReportStates {}

class HomeInitialState extends ReportStates {}

class HouseLoadingState extends ReportStates {}

class HouseSuccessState extends ReportStates {
  final ReportHouseModel house;

  HouseSuccessState(this.house);
}

class HouseErrorState extends ReportStates {
  final String error;

  HouseErrorState(this.error);
}

class MoneyHousesLoadingState extends ReportStates {}

class MoneyHousesSuccessState extends ReportStates {
  final ReportMoneyModel money;

  MoneyHousesSuccessState(this.money);
}

class MoneyHousesErrorState extends ReportStates {
  final String error;

  MoneyHousesErrorState(this.error);
}

class SecurityCleanLoadingState extends ReportStates {}

class SecurityCleanSuccessState extends ReportStates {
  final ReportSecurityCleanModel security;

  SecurityCleanSuccessState(this.security);
}

class SecurityCleanErrorState extends ReportStates {
  final String error;

  SecurityCleanErrorState(this.error);
}

class ServiceLoadingState extends ReportStates {}

class ServiceSuccessState extends ReportStates {
  final ReportServiceModel service;

  ServiceSuccessState(this.service);
}

class ServiceErrorState extends ReportStates {
  final String error;

  ServiceErrorState(this.error);
}

class ServiceRequestLoadingState extends ReportStates {}

class ServiceRequestSuccessState extends ReportStates {
  final ReportServiceRequestModel serviceRequest;

  ServiceRequestSuccessState(this.serviceRequest);
}

class ServiceRequestErrorState extends ReportStates {
  final String error;

  ServiceRequestErrorState(this.error);
}
