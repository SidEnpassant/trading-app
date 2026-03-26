import 'package:trading/features/auth/data/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password, String name);
  Future<void> logout();
}
