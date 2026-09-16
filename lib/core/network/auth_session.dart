import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw StateError('sharedPreferencesProvider must be overridden in main()');
});

final authSessionProvider = Provider<AuthSession>((ref) {
  return AuthSession(ref.watch(sharedPreferencesProvider));
});

class AuthSession {
  AuthSession(this._prefs);

  static const _tokenKey = 'auth_token';
  static const _agentCodeKey = 'agent_code';
  static const _bankCodeKey = 'bank_code';
  static const _agentNameKey = 'agent_name';

  final SharedPreferences _prefs;

  String? get token => _prefs.getString(_tokenKey);
  String? get agentCode => _prefs.getString(_agentCodeKey);
  String? get bankCode => _prefs.getString(_bankCodeKey);
  String? get agentName => _prefs.getString(_agentNameKey);

  bool get hasToken => token != null && token!.isNotEmpty;

  Future<void> save({
    String? token,
    String? agentCode,
    String? bankCode,
    String? agentName,
  }) async {
    if (token != null) await _prefs.setString(_tokenKey, token);
    if (agentCode != null) await _prefs.setString(_agentCodeKey, agentCode);
    if (bankCode != null) await _prefs.setString(_bankCodeKey, bankCode);
    if (agentName != null) await _prefs.setString(_agentNameKey, agentName);
  }

  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_agentCodeKey);
    await _prefs.remove(_bankCodeKey);
    await _prefs.remove(_agentNameKey);
  }
}
