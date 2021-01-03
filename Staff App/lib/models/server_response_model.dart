class ServerResponse {
  final bool backendConnected;
  final bool addressdeleted;
  final bool addressDetailsSaved;
  final bool deliveryDetailsSaved;
  final bool deliveryDetailsEdited;
  final String token;
  final String message;
  ServerResponse(
      {this.backendConnected,
      this.addressdeleted,
      this.addressDetailsSaved,
      this.deliveryDetailsSaved,
      this.deliveryDetailsEdited,
      this.token,
      this.message});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
        backendConnected: json['backendConnected'] as bool,
        addressdeleted: json['addressdeleted'] as bool,
        addressDetailsSaved: json['addressDetailsSaved'] as bool,
        deliveryDetailsSaved: json['deliveryDetailsSaved'] as bool,
        deliveryDetailsEdited: json['deliveryDetailsEdited'] as bool,
        token: json['token'] as String,
        message: json['message']);
  }
}
