import 'package:equatable/equatable.dart';
import 'package:lamassu/models/monthly_bills_model.dart';

abstract class BillsState extends Equatable {
  const BillsState();

  @override
  List<Object> get props => [];
}

class BillsLoadingState extends BillsState {
  const BillsLoadingState();
}

class BillsSuccessState extends BillsState {
  final List<MonthlyBillsModel> bills;
  const BillsSuccessState(this.bills);

  @override
  List<Object> get props => [bills];
}

class BillsErrorState extends BillsState {
  final String message;
  const BillsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
