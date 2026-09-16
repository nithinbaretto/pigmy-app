class AuthActionResult {
  const AuthActionResult({required this.success, this.message = ''});

  final bool success;
  final String message;
}

class RegisterDeviceResponse {
  const RegisterDeviceResponse({
    required this.success,
    required this.successMessage,
  });

  final bool success;
  final String successMessage;

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) {
    return RegisterDeviceResponse(
      success: json['success'] == true,
      successMessage: (json['successMessage'] ?? '').toString(),
    );
  }
}

class CheckDeviceResponse {
  const CheckDeviceResponse({
    required this.success,
    required this.successMessage,
    required this.isRegistered,
    required this.isApproved,
    this.token,
  });

  final bool success;
  final String successMessage;
  final bool isRegistered;
  final bool isApproved;
  final String? token;

  factory CheckDeviceResponse.fromJson(Map<String, dynamic> json) {
    final rawToken = json['token'];
    return CheckDeviceResponse(
      success: json['success'] == true,
      successMessage: (json['successMessage'] ?? '').toString(),
      isRegistered: json['isRegistered'] == true,
      isApproved: json['isApproved'] == true,
      token: rawToken is String && rawToken.isNotEmpty ? rawToken : null,
    );
  }
}

class DeviceDetailsResponse {
  const DeviceDetailsResponse({
    required this.success,
    required this.successMessage,
    this.bankCode,
    this.agentCode,
    this.agentName,
  });

  final bool success;
  final String successMessage;
  final String? bankCode;
  final String? agentCode;
  final String? agentName;

  bool get hasAgentDetails =>
      (bankCode != null && bankCode!.isNotEmpty) &&
      (agentCode != null && agentCode!.isNotEmpty);

  factory DeviceDetailsResponse.fromJson(Map<String, dynamic> json) {
    String? opt(dynamic v) {
      if (v == null) return null;
      final s = v.toString();
      return s.isEmpty ? null : s;
    }

    return DeviceDetailsResponse(
      success: json['success'] == true,
      successMessage: (json['successMessage'] ?? '').toString(),
      bankCode: opt(json['bankCode']),
      agentCode: opt(json['agentCode']),
      agentName: opt(json['agentName']),
    );
  }
}
