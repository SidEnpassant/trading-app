import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String pan;
  final DateTime dob;
  final String profilePicUrl;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.pan,
    required this.dob,
    required this.profilePicUrl,
  });

  @override
  List<Object?> get props => [name, email, phone, pan, dob, profilePicUrl];
}
