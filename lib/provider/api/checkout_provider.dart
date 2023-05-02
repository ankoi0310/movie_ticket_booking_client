import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:http/http.dart' as http;

class CheckoutProvider extends ChangeNotifier {
  Invoice? _invoice;
  final List<Invoice> _invoices = [];

  Invoice? get invoice => _invoice;

  List<Invoice> get invoices => _invoices;

  Future<void> createInvoice(Invoice invoice) async {

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8081/api/v1/checkout'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(invoice.toJson()),
        );

        Map httpResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (response.statusCode == 200) {

          _invoice = Invoice.fromJson(httpResponse['data']);
        }
        // else if (response.statusCode == 400) {
        //   throw BadRequestException(httpResponse['message']);
        // }
      } catch (_) {
        print('error: $_');
        rethrow;
      }
  }
}