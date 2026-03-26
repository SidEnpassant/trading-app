import 'package:trading/features/profile/data/datasources/profile_datasource.dart';
import 'package:trading/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:trading/features/profile/data/repositories/profile_repository.dart';
import 'package:trading/features/profile/data/models/user_profile.dart';
import 'package:trading/features/profile/data/models/account_details.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl({ProfileDataSource? dataSource})
    : _dataSource = dataSource ?? ProfileDataSourceImpl();

  @override
  Future<UserProfile> getUserProfile() {
    return _dataSource.getUserProfile();
  }

  @override
  Future<AccountDetails> getAccountDetails() {
    return _dataSource.getAccountDetails();
  }

  @override
  Future<void> logout() {
    return _dataSource.logout();
  }
}
