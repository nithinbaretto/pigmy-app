import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/auth_session.dart';
import '../../../core/utils/device_id.dart';
import '../model/auth_api_models.dart';
import '../model/auth_state.dart';
import '../service/auth_service.dart';
import 'auth_repository.dart';

/// Existing Username field → agentCode; Password field → bankCode.
/// agentName is sent as the same value as agentCode (no extra UI field).
class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository({
    required AuthService authService,
    required AuthSession session,
    required SharedPreferences prefs,
  })  : _authService = authService,
        _session = session,
        _prefs = prefs;

  final AuthService _authService;
  final AuthSession _session;
  final SharedPreferences _prefs;

  AppMode _appMode = AppMode.online;
  bool _isLoggedIn = false;

  @override
  AppMode get appMode => _appMode;

  @override
  set appMode(AppMode mode) => _appMode = mode;

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  Future<AuthActionResult> register({
    required String username,
    required String password,
  }) async {
    try {
      final deviceId = await DeviceId.resolve(_prefs);
      final agentCode = username.trim();
      final bankCode = password.trim();
      final result = await _authService.registerDevice(
        deviceId: deviceId,
        bankCode: bankCode,
        agentCode: agentCode,
        agentName: agentCode,
      );
      if (!result.success) {
        return AuthActionResult(
          success: false,
          message: result.successMessage.isEmpty
              ? 'Registration failed'
              : result.successMessage,
        );
      }
      await _session.save(
        agentCode: agentCode,
        bankCode: bankCode,
        agentName: agentCode,
      );
      return AuthActionResult(success: true, message: result.successMessage);
    } on DioException catch (e) {
      return AuthActionResult(success: false, message: _dioMessage(e));
    } catch (e) {
      return AuthActionResult(success: false, message: e.toString());
    }
  }

  @override
  Future<AuthActionResult> login({
    required String username,
    required String password,
  }) async {
    try {
      final deviceId = await DeviceId.resolve(_prefs);
      final agentCode = username.trim();
      final bankCode = password.trim();
      final result = await _authService.checkDevice(
        deviceId: deviceId,
        bankCode: bankCode,
        agentCode: agentCode,
      );
      if (!result.success) {
        return AuthActionResult(
          success: false,
          message: result.successMessage.isEmpty
              ? 'Login failed'
              : result.successMessage,
        );
      }
      if (result.isApproved && result.token != null) {
        await _session.save(
          token: result.token,
          agentCode: agentCode,
          bankCode: bankCode,
        );
        _isLoggedIn = true;
        return AuthActionResult(success: true, message: result.successMessage);
      }
      _isLoggedIn = false;
      return AuthActionResult(
        success: false,
        message: result.successMessage.isEmpty
            ? 'Device is not approved yet'
            : result.successMessage,
      );
    } on DioException catch (e) {
      return AuthActionResult(success: false, message: _dioMessage(e));
    } catch (e) {
      return AuthActionResult(success: false, message: e.toString());
    }
  }

  @override
  Future<bool> restoreSession() async {
    try {
      final deviceId = await DeviceId.resolve(_prefs);
      final details = await _authService.detailsByDeviceId(deviceId);
      if (details.hasAgentDetails) {
        await _session.save(
          agentCode: details.agentCode,
          bankCode: details.bankCode,
          agentName: details.agentName,
        );
        final result = await login(
          username: details.agentCode!,
          password: details.bankCode!,
        );
        return result.success;
      }
    } catch (_) {
      // Fall through to stored credentials.
    }

    final agentCode = _session.agentCode;
    final bankCode = _session.bankCode;
    if (agentCode == null ||
        agentCode.isEmpty ||
        bankCode == null ||
        bankCode.isEmpty) {
      return false;
    }
    final result = await login(username: agentCode, password: bankCode);
    return result.success;
  }

  @override
  Future<void> logout() async {
    _isLoggedIn = false;
    await _session.clear();
  }

  String _dioMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['successMessage'] != null) {
      return data['successMessage'].toString();
    }
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    if (e.message != null && e.message!.isNotEmpty) return e.message!;
    return 'Unable to reach server';
  }
}
