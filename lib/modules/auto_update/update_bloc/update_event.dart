import 'package:equatable/equatable.dart';

abstract class MainUpdateEvent extends Equatable {
  const MainUpdateEvent();

  @override
  List<Object> get props => [];
}

class CheckUpdateEvent extends MainUpdateEvent {
  const CheckUpdateEvent();
}