import 'package:lamassu/models/electric_model.dart';

abstract class ElectricState {}

class ElectricLoadingState extends ElectricState {}

class ElectricSuccessState extends ElectricState {
  final ElectricModel? electric;

  ElectricSuccessState(this.electric);
}

class ElectricErrorState extends ElectricState {
  final String error;

  ElectricErrorState(this.error);
}
