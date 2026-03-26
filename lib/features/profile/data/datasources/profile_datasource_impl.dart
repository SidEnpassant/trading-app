import 'package:trading/features/profile/data/datasources/profile_datasource.dart';
import 'package:trading/features/profile/data/models/user_profile.dart';
import 'package:trading/features/profile/data/models/account_details.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserProfile(
      name: 'Rahul Kumar',
      email: 'rahul.kumar@email.com',
      phone: '+91 9876543210',
      pan: 'ABCDE1234F',
      dob: DateTime(1990, 5, 15),
      profilePicUrl: '',
    );
  }

  @override
  Future<AccountDetails> getAccountDetails() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AccountDetails(
      accountNumber: 'TT****6789',
      balance: 125430.50,
      panVerified: true,
      kycStatus: 'Verified',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
