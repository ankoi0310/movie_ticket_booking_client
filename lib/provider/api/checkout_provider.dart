import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_flutter_nlu/dto/invoice/invoice_create.dart';

class CheckoutProvider extends ChangeNotifier {
  Invoice? _invoice;
  final List<Invoice> _invoices = [];
  MomoResponse? _momoResponse;

  Invoice? get invoice => _invoice;

  List<Invoice> get invoices => _invoices;

  MomoResponse? get momoResponse => _momoResponse;

  Future<MomoResponse> createInvoice(InvoiceCreate create) async {
    print(create.invoiceCombos.map((e) => e.toJson()).toList());
    try {
        final response = await http.post(
          Uri.parse('http://localhost:8081/api/v1/checkout'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(create.toJson()),
        );

      Map httpResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {

          _momoResponse = MomoResponse.fromJson(httpResponse['data']);
      }

        return _momoResponse!;
        // else if (response.statusCode == 400) {
        //   throw BadRequestException(httpResponse['message']);
        // }
      } catch (_) {
        print('error: $_');
        rethrow;
      }
  }
}