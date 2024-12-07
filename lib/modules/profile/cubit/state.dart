

import '../../../models/VisitsModel.dart';
import '../../../models/about_app_model.dart';
import '../../../models/owner_profile_model.dart';


abstract class OwnerProfileStates {}

class OwnerProfileInitialState extends OwnerProfileStates {}

class OwnerProfileGetLoadingState extends OwnerProfileStates {}

class OwnerProfileGetSuccessState extends OwnerProfileStates {
  final OwnerProfileModel ownerProfile;

  OwnerProfileGetSuccessState(this.ownerProfile);
}

class OwnerProfileGetErrorState extends OwnerProfileStates {
  final String error;

  OwnerProfileGetErrorState(this.error);
}




class updateProfileGetLoadingState extends OwnerProfileStates {}

class updateProfileGetSuccessState extends OwnerProfileStates {
}

class updateProfileGetErrorState extends OwnerProfileStates {
  final String error;

  updateProfileGetErrorState(this.error);
}





class OwnerVisitsGetLoadingState extends OwnerProfileStates {}

class OwnerVisitsGetSuccessState extends OwnerProfileStates {
  final VisitsModel ownerVisits;

  OwnerVisitsGetSuccessState(this.ownerVisits);
}

class OwnerVisitsGetErrorState extends OwnerProfileStates {
  final String error;

  OwnerVisitsGetErrorState(this.error);
}



class AboutAppLoadingState extends OwnerProfileStates {}

class AboutAppSuccessState extends OwnerProfileStates {
  final AboutAppModel? aboutAppModel;

  AboutAppSuccessState(this.aboutAppModel);
}

class AboutAppErrorState extends OwnerProfileStates {
  final String error;

  AboutAppErrorState(this.error);
}



class complainLoadingState extends OwnerProfileStates {}

class complainSuccessState extends OwnerProfileStates {
}

class complainErrorState extends OwnerProfileStates {
  final String error;

  complainErrorState(this.error);
}

