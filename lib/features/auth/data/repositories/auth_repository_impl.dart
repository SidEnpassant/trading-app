import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/utils/logger.dart';
import 'package:trading/features/auth/data/datasources/auth_datasource.dart';
import 'package:trading/features/auth/data/models/user.dart';
import 'package:trading/features/auth/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  static const String _tokenKey = 'auth_token';

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<User> login(String email, String password) async {
    try {
      Logger.debug('Attempting login for $email');
      final user = await authDataSource.login(email, password);
      await _saveToken(user.token);
      Logger.info('Login successful for ${user.email}');
      return user;
    } catch (e) {
      Logger.error('Login failed', e);
      rethrow;
    }
  }

  @override
  Future<User> signup(String email, String password, String name) async {
    try {
      Logger.debug('Attempting signup for $email');
      final user = await authDataSource.signup(email, password, name);
      await _saveToken(user.token);
      Logger.info('Signup successful for ${user.email}');
      return user;
    } catch (e) {
      Logger.error('Signup failed', e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      Logger.debug('Logging out user');
      await authDataSource.logout();
      await _clearToken();
      Logger.info('Logout successful');
    } catch (e) {
      Logger.error('Logout failed', e);
      rethrow;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
