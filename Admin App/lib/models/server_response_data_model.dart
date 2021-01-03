class ServerResponse {
  final bool backendConnected;
  final bool auth;
  final bool tokenValidation;
  final bool adminPasswordChange;
  final bool staffDetailsSaved;
  final bool staffDetailsdeleted;
  final bool addressDetailsSaved;
  final bool addressdeleted;
  final bool deliveryDetailsUpdated;
  final String token;
  final String message;

  ServerResponse(
      {this.backendConnected,
      this.auth,
      this.tokenValidation,
      this.adminPasswordChange,
      this.staffDetailsdeleted,
      this.staffDetailsSaved,
      this.addressDetailsSaved,
      this.addressdeleted,
      this.token,
      this.message,
      this.deliveryDetailsUpdated});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      backendConnected: json['backendConnected'] as bool,
      auth: json['auth'] as bool,
      tokenValidation: json['tokenValidation'] as bool,
      adminPasswordChange: json['adminPasswordChange'] as bool,
      staffDetailsSaved: json['staffDetailsSaved'] as bool,
      staffDetailsdeleted: json['staffDetailsdeleted'] as bool,
      addressDetailsSaved: json['addressDetailsSaved'] as bool,
      addressdeleted: json['addressdeleted'] as bool,
      deliveryDetailsUpdated: json['deliveryDetailsUpdated'],
      token: json['token'] as String,
      message: json['message'] as String,
    );
  }
}
