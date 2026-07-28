import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import '../../core/network/network_info.dart';
import '../../features/auth/service/auth_service.dart';

/// Global service providers — placeholders for future integration.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(dioProvider));
});

final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfo());
