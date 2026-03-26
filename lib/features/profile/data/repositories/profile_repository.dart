import 'package:trading/features/profile/data/models/user_profile.dart';
import 'package:trading/features/profile/data/models/account_details.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<AccountDetails> getAccountDetails();
  Future<void> logout();
}
