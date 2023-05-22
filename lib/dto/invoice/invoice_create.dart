import 'package:movie_ticket_booking_flutter_nlu/model/invoice_combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
class InvoiceCreate {
  String name;
  String email;
  String paymentMethod;
  ShowTime showtime;
  int totalPrice;
  List<Seat> seats;
  Set<InvoiceCombo>? invoiceCombos;

  InvoiceCreate({
    required this.name,
    required this.email,
    required this.paymentMethod,
    required this.showtime,
    required this.totalPrice,
    required this.seats,
    required this.invoiceCombos,
  });

  InvoiceCreate.empty()
      : name = '',
        email = '',
        paymentMethod = PaymentMethod.momo.value,
        showtime = ShowTime.empty(),
        totalPrice = 0,
        invoiceCombos = {},
        seats = [];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'paymentMethod': paymentMethod,
      'showtime': showtime.toJson(),
      'totalPrice': totalPrice,
      'seats': seats.map((e) => e.toJson()).toList(),
      'invoiceCombos': invoiceCombos!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  bool operator ==(other) {
    return (other is InvoiceCreate) && other.name == name && other.email == email && other.paymentMethod == paymentMethod && other.showtime == showtime && other.seats == seats;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ paymentMethod.hashCode ^ showtime.hashCode ^ seats.hashCode;




}