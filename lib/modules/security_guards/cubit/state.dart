

import 'package:lamassu/models/quard_visits.dart';

import '../../../models/check_qr_model.dart';
import '../../../models/owner_profile_model.dart';


abstract class GuardsProfileStates {}

class GuardsProfileInitialState extends GuardsProfileStates {}

class GuardsProfileGetLoadingState extends GuardsProfileStates {}

class GuardsProfileGetSuccessState extends GuardsProfileStates {
  final OwnerProfileModel GuardsProfile;

  GuardsProfileGetSuccessState(this.GuardsProfile);
}

class GuardsProfileGetErrorState extends GuardsProfileStates {
  final String error;

  GuardsProfileGetErrorState(this.error);
}




class updateGuardsProfileGetLoadingState extends GuardsProfileStates {}

class updateGuardsProfileGetSuccessState extends GuardsProfileStates {
}

class updateGuardsProfileGetErrorState extends GuardsProfileStates {
  final String error;

  updateGuardsProfileGetErrorState(this.error);
}




class CheckQrLoadingState extends GuardsProfileStates {}

class CheckQrSuccessState extends GuardsProfileStates {
  final CheckQrModel? visitResponse;

  CheckQrSuccessState(this.visitResponse);
}

class CheckQrErrorState extends GuardsProfileStates {
  final String error;

  CheckQrErrorState(this.error);
}


class GuardVisitsGetLoadingState extends GuardsProfileStates {}


class GuardVisitsGetSuccessState extends GuardsProfileStates {
  final GuardVisits? quardVisits;

  GuardVisitsGetSuccessState(this.quardVisits);
}

class GuardVisitsGetErrorState extends GuardsProfileStates {
  final String error;

  GuardVisitsGetErrorState(this.error);
}
