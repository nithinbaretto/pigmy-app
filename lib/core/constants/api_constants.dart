/// iPoll device-registration APIs from app-register-api.xlsx.
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://software.ipolltechnologies.com:3001';

  static const String registerDevice = '/api/app-register-device';
  static const String checkDevice = '/api/app-check-device';
  static const String detailsByDeviceId = '/api/app-details-by-deviceid';
}
