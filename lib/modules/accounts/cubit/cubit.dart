import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/modules/accounts/cubit/state.dart';
import 'package:lamassu/shared/components/local_database/models/account.dart';
import 'package:lamassu/shared/components/local_database/sql_database.dart';

class AccountsCubit extends Cubit<AccountStates> {
  AccountsCubit() : super(AccountInitialState());

  static AccountsCubit get(context) => BlocProvider.of(context);

  List<Account>? accounts;

  Future<void> getAccounts() async {
    emit(AccountGetAccountLoadingState());

    try {
      accounts = await SqlDatabase().getAllAccount();
      if (accounts!.isNotEmpty) {
        emit(AccountGetAccountSuccessState(accounts!));
      } else {
        emit(AccountGetAccountErrorState("لا توجد حسابات"));
      }
    } catch (e) {
      emit(AccountGetAccountErrorState('Error: $e'));
    }
  }

  Future<void> deleteAccount(String email) async {
    emit(AccountGetAccountLoadingState());
    await SqlDatabase().deleteAccount(email);
    getAccounts();
  }

  Future<void> updateAccount(
      String email, Map<String, dynamic> updatedData) async {
    emit(AccountGetAccountLoadingState());
    await SqlDatabase().updateUser(email, updatedData);

    getAccounts();
  }

  Future<void> insertAccount(Account account) async {
    emit(AccountGetAccountLoadingState());
    await SqlDatabase().insertAccount(account);
    getAccounts();
  }

  Future<void> insertAccountAsMap(Map<String, dynamic> account) async {
    emit(AccountGetAccountLoadingState());
    await SqlDatabase().insertAccountAsMap(account);
    getAccounts();
  }
}
