import 'package:equatable/equatable.dart';

sealed class ApiState extends Equatable {}

class ApiInitial extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiLoading extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiSuccess extends ApiState {
  final String title;

  ApiSuccess(this.title);

  @override
  List<Object?> get props => [title];
}

class ApiFailure extends ApiState {
  final String message;

  ApiFailure(this.message);

  @override
  List<Object?> get props => [message];
}
