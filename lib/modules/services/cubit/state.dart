

import '../../../models/qr_generate_model.dart';
import '../../../models/reservations_service_model.dart';
import '../../../models/salary_owner_services_model.dart';
import '../../../models/services_model.dart';

abstract class ServicesStates {}

class ServicesInitialState extends ServicesStates {}

class ServicesGetLoadingState extends ServicesStates {}

class ServicesGetSuccessState extends ServicesStates {
  final List<ServicesResults> services;

  ServicesGetSuccessState(this.services);
}

class ServicesGetErrorState extends ServicesStates {
  final String error;

  ServicesGetErrorState(this.error);
}
class ServicesUnauthorizedState extends ServicesStates {

}



class ServicesReservationsGetLoadingState extends ServicesStates {}

class ServicesReservationsGetSuccessState extends ServicesStates {
  final ReservationsServiceModel services;

  ServicesReservationsGetSuccessState(this.services);
}

class ServicesReservationsGetErrorState extends ServicesStates {
  final String error;

  ServicesReservationsGetErrorState(this.error);
}



class ServicesInvoicesGetLoadingState extends ServicesStates {}

class ServicesInvoicesGetSuccessState extends ServicesStates {
  final SalaryServicesModel invoices;

  ServicesInvoicesGetSuccessState(this.invoices);
}

class ServicesInvoicesGetErrorState extends ServicesStates {
  final String error;

  ServicesInvoicesGetErrorState(this.error);
}




class QrGenerateGetLoadingState extends ServicesStates {}

class QrGenerateGetSuccessState extends ServicesStates {
  final QrGenerate qrGenerate;

  QrGenerateGetSuccessState(this.qrGenerate);
}

class QrGenerateGetErrorState extends ServicesStates {
  final String error;

  QrGenerateGetErrorState(this.error);
}



