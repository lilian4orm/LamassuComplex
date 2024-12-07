import '../../../models/user_model.dart';

class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginGetLoginLoadingState extends LoginStates {}

class LoginGetLoginSuccessState extends LoginStates {
  final UserModel loginData;

  LoginGetLoginSuccessState(this.loginData);
}

class LoginGetLoginErrorState extends LoginStates {
  final String error;

  LoginGetLoginErrorState(this.error);
}


class LoginGetLogoutLoadingState extends LoginStates {}

class LoginGetLogoutSuccessState extends LoginStates {
}

class LoginGetLogoutErrorState extends LoginStates {
  final String error;

  LoginGetLogoutErrorState(this.error);
}
