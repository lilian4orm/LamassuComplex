

import '../../../models/salary_owner_model.dart';

abstract class PaymentsStates {}

class PaymentsInitialState extends PaymentsStates {}

class PaymentsGetWonerLoadingState extends PaymentsStates {}

class PaymentsGetWonerSuccessState extends PaymentsStates {
  final SalaryOwnerModel payments;

  PaymentsGetWonerSuccessState(this.payments);
}

class PaymentsGetWonerErrorState extends PaymentsStates {
  final String error;

  PaymentsGetWonerErrorState(this.error);
}



