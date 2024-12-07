import 'package:equatable/equatable.dart';
import 'package:lamassu/models/VisitsModel.dart';

abstract class VisitordState extends Equatable {
  const VisitordState();

  @override
  List<Object> get props => [];
}

class VisitordLoadingState extends VisitordState {
  const VisitordLoadingState();
}

class VisitordSuccessState extends VisitordState {
  final VisitsModel visitor;
  const VisitordSuccessState(this.visitor);

  @override
  List<Object> get props => [visitor];
}

class VisitordErrorState extends VisitordState {
  final String message;
  const VisitordErrorState(this.message);

  @override
  List<Object> get props => [message];
}
