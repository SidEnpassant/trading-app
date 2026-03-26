import 'package:equatable/equatable.dart';
import 'package:trading/features/profile/data/models/user_profile.dart';
import 'package:trading/features/profile/data/models/account_details.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  final AccountDetails account;

  const ProfileLoaded({required this.profile, required this.account});

  @override
  List<Object?> get props => [profile, account];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
