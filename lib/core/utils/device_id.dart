import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:media_drm_id/media_drm_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceId {
  DeviceId._();

  static const _fallbackKey = 'device_id_fallback';

  /// Hardware-backed id that stays the same after uninstall/reinstall.
  /// Factory reset can still change it on some devices.
  static Future<String> resolve(SharedPreferences prefs) async {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final info = await DeviceInfoPlugin().iosInfo;
        final id = info.identifierForVendor?.trim();
        if (id != null && id.isNotEmpty) {
          debugPrint('PIGMY_DEVICE_ID unique iOS vendor=$id');
          return id;
        }
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final drmId = (await MediaDrmId.deviceId)?.trim();
        final androidId = (await const AndroidId().getId())?.trim();
        debugPrint(
          'PIGMY_DEVICE_ID drm=$drmId androidId=$androidId',
        );
        if (drmId != null && drmId.isNotEmpty) return drmId;
        if (androidId != null && androidId.isNotEmpty) return androidId;
      }
    } catch (e) {
      debugPrint('PIGMY_DEVICE_ID lookup failed: $e');
    }

    final existing = prefs.getString(_fallbackKey);
    if (existing != null && existing.isNotEmpty) {
      debugPrint('PIGMY_DEVICE_ID fallback stored=$existing');
      return existing;
    }
    final generated = const Uuid().v4();
    await prefs.setString(_fallbackKey, generated);
    debugPrint('PIGMY_DEVICE_ID fallback generated=$generated');
    return generated;
  }
}
