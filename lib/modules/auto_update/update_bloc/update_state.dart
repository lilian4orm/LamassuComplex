import 'package:equatable/equatable.dart';

abstract class MainUpdateState extends Equatable {
  const MainUpdateState();

  @override
  List<Object> get props => [];
}

class UpdateLoadingState extends MainUpdateState {
  const UpdateLoadingState();
}

class UpdateSuccessState extends MainUpdateState {
  const UpdateSuccessState();
}

class UpdateNoUpdateState extends MainUpdateState {
  final String message;
  UpdateNoUpdateState(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateDownloadState extends MainUpdateState {
  final String message;
  const UpdateDownloadState(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateErrorState extends MainUpdateState {
  final String message;
  const UpdateErrorState(this.message);
  @override
  List<Object> get props => [message];
}
