import 'package:equatable/equatable.dart';
import 'package:lamassu/models/service_model.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceLoadingState extends ServiceState {
  const ServiceLoadingState();
}

class ServiceSuccessState extends ServiceState {
  final List roomNameList;
  final List typeList;

  const ServiceSuccessState(this.typeList, this.roomNameList);

  @override
  List<Object> get props => [Service];
}

class ServiceErrorState extends ServiceState {
  final String message;
  const ServiceErrorState(this.message);

  @override
  List<Object> get props => [message];
}
