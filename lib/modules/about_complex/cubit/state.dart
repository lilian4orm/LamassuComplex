import 'package:lamassu/models/canter_model.dart';

import '../../../models/form_model/form_houses_and_rooms.dart';
import '../../../models/form_model/form_name.dart';

abstract class CenterStates {}

class CenterInitialState extends CenterStates {}

class CenterGetcenterLoadingState extends CenterStates {}

class CenterGetcenterSuccessState extends CenterStates {
  final Results? centerAd;

  CenterGetcenterSuccessState(this.centerAd);
}

class CenterGetcenterErrorState extends CenterStates {
  final String error;

  CenterGetcenterErrorState(this.error);
}

// class centerFormsLoadingState extends CenterStates {}
//
// class centerFormsSuccessState extends CenterStates {
//   final form.centerForms? CenterForms;
//
//   centerFormsSuccessState(this.CenterForms);
// }
//
// class centerFormsErrorState extends CenterStates {
//   final String error;
//
//   centerFormsErrorState(this.error);
// }

class FormNameLoadingState extends CenterStates {}

class FormNameSuccessState extends CenterStates {
  final FormNameModel? FormName;

  FormNameSuccessState(this.FormName);
}

class FormNameErrorState extends CenterStates {
  final String error;

  FormNameErrorState(this.error);
}

class HouseNameLoadingState extends CenterStates {}

class HouseNameSuccessState extends CenterStates {
  final HousesandRoomModel? HouseNmae;

  HouseNameSuccessState(this.HouseNmae);
}

class HouseNameErrorState extends CenterStates {
  final String error;

  HouseNameErrorState(this.error);
}
