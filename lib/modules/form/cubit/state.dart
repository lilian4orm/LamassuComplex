import '../../../models/apartment/apartment_tower_floor_model.dart';
import '../../../models/apartment/apartment_towers_model.dart';
import '../../../models/apartment/towers_floors_model.dart';
import '../../../models/center_forms.dart';
import '../../../models/form_model/form_houses.dart';
import '../../../models/form_model/form_name.dart';
import '../../../models/how_hear_about.dart';
import '../../../models/show_application_form_model.dart';
import '../../../models/show_apply_form_model.dart';
import '../../../models/show_customer_form_model.dart';

abstract class FormAStates {}

class FormInitialState extends FormAStates {}



class CustomerFormLoadingState extends FormAStates {}

class CustomerFormSuccessState extends FormAStates {
}

class CustomerFormErrorState extends FormAStates {
  final String error;

  CustomerFormErrorState(this.error);
}



class howHearLoadingState extends FormAStates {}

class howHearSuccessState extends FormAStates {
  final howHearAbout? HowHearAbout;

  howHearSuccessState(this.HowHearAbout);
}

class howHearErrorState extends FormAStates {
  final String error;

  howHearErrorState(this.error);
}




class centerFormsLoadingState extends FormAStates {}

class centerFormsSuccessState extends FormAStates {
  final centerForms? CenterForms;

  centerFormsSuccessState(this.CenterForms);
}

class centerFormsErrorState extends FormAStates {
  final String error;

  centerFormsErrorState(this.error);
}





class ShowCustomerFormsLoadingState extends FormAStates {}

class ShowCustomerFormsSuccessState extends FormAStates {
  final ShowCustomerFormModel? ShowCustomer;

  ShowCustomerFormsSuccessState(this.ShowCustomer);
}

class ShowCustomerFormsErrorState extends FormAStates {
  final String error;

  ShowCustomerFormsErrorState(this.error);
}




class EditCustomerFormLoadingState extends FormAStates {}

class EditCustomerFormSuccessState extends FormAStates {
}

class EditCustomerFormErrorState extends FormAStates {
  final String error;

  EditCustomerFormErrorState(this.error);
}







class ShowApplicationFormLoadingState extends FormAStates {}

class ShowApplicationFormSuccessState extends FormAStates {
  final ShowApplicationFormModel? showApplicationForm;

  ShowApplicationFormSuccessState(this.showApplicationForm);
}

class ShowApplicationFormErrorState extends FormAStates {
  final String error;

  ShowApplicationFormErrorState(this.error);
}




class ApplyFormLoadingState extends FormAStates {}

class ApplyFormSuccessState extends FormAStates {
}

class ApplyFormErrorState extends FormAStates {
  final String error;

  ApplyFormErrorState(this.error);
}




class ShowApplyFormsLoadingState extends FormAStates {}

class ShowApplyFormsSuccessState extends FormAStates {
  final ShowApplyFormModel? ShowApply;

  ShowApplyFormsSuccessState(this.ShowApply);
}

class ShowApplyFormsErrorState extends FormAStates {
  final String error;

  ShowApplyFormsErrorState(this.error);
}


class FormName2LoadingState extends FormAStates {}

class FormName2SuccessState extends FormAStates {
  final FormNameModel? FormName;

  FormName2SuccessState(this.FormName);
}

class FormName2ErrorState extends FormAStates {
  final String error;

  FormName2ErrorState(this.error);
}





class HouseName2LoadingState extends FormAStates {}

class HouseName2SuccessState extends FormAStates {
  final HouseNmaeModel? HouseNmae;

  HouseName2SuccessState(this.HouseNmae);
}

class HouseName2ErrorState extends FormAStates {
  final String error;

  HouseName2ErrorState(this.error);
}




////////////////////////////////////////////////////////////////////////////


class FloorsLoadingState extends FormAStates {}

class FloorsSuccessState extends FormAStates {
  final TowersFloorsModel? Floors;

  FloorsSuccessState(this.Floors);
}

class FloorsErrorState extends FormAStates {
  final String error;

  FloorsErrorState(this.error);
}





class TowersLoadingState extends FormAStates {}

class TowersSuccessState extends FormAStates {
  final ApartmentTowersModel? Towers;

  TowersSuccessState(this.Towers);
}

class TowersErrorState extends FormAStates {
  final String error;

  TowersErrorState(this.error);
}






class ApartmentTowerFloorLoadingState extends FormAStates {}

class ApartmentTowerFloorSuccessState extends FormAStates {
  final ApartmentTowerAndFloorModel? ApartmentTowerFloor;

  ApartmentTowerFloorSuccessState(this.ApartmentTowerFloor);
}

class ApartmentTowerFloorErrorState extends FormAStates {
  final String error;

  ApartmentTowerFloorErrorState(this.error);
}





class TransferredLoadingState extends FormAStates {}

class TransferredSuccessState extends FormAStates {

}

class TransferredErrorState extends FormAStates {
  final String error;

  TransferredErrorState(this.error);
}

