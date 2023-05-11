class PaymentResponse {
  String? partnerCode;
  String? orderId;
  String? requestId;
  int amount;
  String? orderInfo;
  String? orderType;
  String? transId;
  int resultCode;
  String? message;
  String? payType;
  int responseTime;
  String? extraData;
  String? signature;

  PaymentResponse({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.orderInfo,
    required this.orderType,
    required this.transId,
    required this.resultCode,
    required this.message,
    required this.payType,
    required this.responseTime,
    required this.extraData,
    required this.signature,
  });

  factory PaymentResponse.fromJson(Map<String?, dynamic> json) {
    return PaymentResponse(
      partnerCode: json['partnerCode'],
      orderId: json['orderId'],
      requestId: json['requestId'],
      amount: int.parse(json['amount']),
      orderInfo: json['orderInfo'],
      orderType: json['orderType'],
      transId: json['transId'],
      resultCode: int.parse(json['resultCode']),
      message: json['message'],
      payType: json['payType'],
      responseTime: int.parse(json['responseTime']),
      extraData: json['extraData'],
      signature: json['signature'],
    );
  }
}
