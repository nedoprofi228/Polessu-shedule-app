import 'package:equatable/equatable.dart';

class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class LoadingUser extends RegistrationEvent{}

class Register extends RegistrationEvent {
  final String group;

  const Register({required this.group});
}

class LogOut extends RegistrationEvent{
  
}


