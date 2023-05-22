import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/payment_momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_flutter_nlu/dto/invoice/invoice_create.dart';

class CheckoutProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  Invoice? _invoice;
  final List<Invoice> _invoices = [];
  MomoResponse? _momoResponse;

  Invoice? get invoice => _invoice;

  List<Invoice> get invoices => _invoices;

  MomoResponse? get momoResponse => _momoResponse;

  Future<HttpResponse> createInvoice(InvoiceCreate create) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse("$baseUrl/checkout"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(create.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<void> returnMomo(PaymentMomoResponse paymentResponse) async {
    await http.post(
      Uri.parse('$baseUrl/checkout/momo/return'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        paymentResponse.toJson(),
      ),
    );
  }
}
