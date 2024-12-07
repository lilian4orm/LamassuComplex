import 'package:lamassu/shared/components/local_database/models/account.dart';

abstract class AccountStates {}

class AccountInitialState extends AccountStates {}

class AccountGetAccountLoadingState extends AccountStates {}

class AccountGetAccountSuccessState extends AccountStates {
  final List<Account> Accounts;

  AccountGetAccountSuccessState(this.Accounts);
}

class AccountGetAccountErrorState extends AccountStates {
  final String error;

  AccountGetAccountErrorState(this.error);
}
