import 'package:equatable/equatable.dart';
import 'package:lamassu/models/fines_model.dart';

abstract class FinesState extends Equatable {
  const FinesState();

  @override
  List<Object> get props => [];
}

class FinesLoadingState extends FinesState {
  const FinesLoadingState();
}

class FinesSuccessState extends FinesState {
  final List<FinesModel> fines;
  const FinesSuccessState(this.fines);

  @override
  List<Object> get props => [fines];
}

class FinesErrorState extends FinesState {
  final String message;
  const FinesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
