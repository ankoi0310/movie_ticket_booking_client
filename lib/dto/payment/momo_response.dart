import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';

class MomoResponse {
  String partnerCode;
  String orderId;
  String requestId;
  int amount;
  DateTime responseTime;
  String message;
  int resultCode;
  String payUrl;
  Invoice invoice;

  MomoResponse({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
    required this.invoice,
  });

  MomoResponse.empty()
      : partnerCode = '',
        orderId = '',
        requestId = '',
        amount = 0,
        responseTime = DateTime.now(),
        message = '',
        resultCode = 0,
        payUrl = '',
        invoice = Invoice.empty();

  factory MomoResponse.fromJson(Map<String, dynamic> json) {
    return MomoResponse(
      partnerCode: json['partnerCode'],
      orderId: json['orderId'],
      requestId: json['requestId'],
      amount: json['amount'],
      responseTime: DateFormat('dd-MM-yyyy').parse(json['responseTime']),
      message: json['message'],
      resultCode: json['resultCode'],
      payUrl: json['payUrl'],
      invoice: Invoice.fromJson(json['invoice']),
    );

  }
}