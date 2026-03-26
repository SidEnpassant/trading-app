import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password, String name);
  Future<void> logout();
  Future<String?> getToken();
}

class AuthDataSourceImpl implements AuthDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  AuthDataSourceImpl();

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!email.contains('@')) {
      throw 'Invalid email format';
    }
    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    final token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
    final prefs = await _getPrefs();
    await prefs.setString(_tokenKey, token);
    return User(email: email, name: email.split('@')[0], token: token);
  }

  @override
  Future<User> signup(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!email.contains('@')) {
      throw 'Invalid email format';
    }
    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }
    if (name.trim().isEmpty) {
      throw 'Name is required';
    }

    final token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
    final user = User(email: email, name: name, token: token);

    final prefs = await _getPrefs();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(
      _userKey,
      '{"email":"$email","name":"$name","token":"$token"}',
    );

    return user;
  }

  @override
  Future<void> logout() async {
    final prefs = await _getPrefs();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_tokenKey);
  }
}
