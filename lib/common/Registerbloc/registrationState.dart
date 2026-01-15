import 'package:application/features/registration/domain/entities/User.dart';
import 'package:equatable/equatable.dart';

enum RegisterStatus { loading, registered, unRegistered, failure }

class RegistrationState extends Equatable {
  final String error;
  final RegisterStatus status;
  final User user;
  const RegistrationState({
    this.user = const User(group: ""),
    this.status = RegisterStatus.loading,
    this.error = ""
  });

  RegistrationState copyWith({User? user, RegisterStatus? status, String? error}) {
    return RegistrationState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [status, user];
}
