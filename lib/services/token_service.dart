import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _accessTokenKey = 'accessToken';
  String? _temporaryToken;

  Future<void> saveAccessToken(String token, {bool rememberMe = false}) async {
    if (rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      print('set string $_accessTokenKey');
      await prefs.setString(_accessTokenKey, token);
    } else {
      _temporaryToken = token;
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    return token ?? _temporaryToken;

  }

  Future<void> clearAccessToken() async {
    _temporaryToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }
}
