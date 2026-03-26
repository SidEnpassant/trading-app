import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String field;
  final String value;

  const UpdateProfile({required this.field, required this.value});

  @override
  List<Object?> get props => [field, value];
}

class Logout extends ProfileEvent {}
