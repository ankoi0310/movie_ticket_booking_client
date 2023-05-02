import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/auth/app_user.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/ticket.dart';

enum PaymentMethod {
  momo, vnPay
}

class Invoice extends General {
  String code;
  String name;
  String email;
  AppUser user;
  ShowTime showTime;
  String paymentMethod;
  String paymentStatus;
  DateTime paymentDate;
  List<Ticket> tickets;

  Invoice({
    required int id,
    required this.code,
    required this.name,
    required this.email,
    required this.user,
    required this.showTime,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    required this.tickets,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
            id: id,
            state: state,
            createdDate: createdDate,
            modifiedDate: modifiedDate,
            deletedDate: deletedDate);

  Invoice.empty()
      : code = '',
        name = '',
        email = '',
        user = AppUser.empty(),
        showTime = ShowTime.empty(),
        paymentMethod = PaymentMethod.momo.name,
        paymentStatus = '',
        paymentDate = DateTime.now(),
        tickets = [],
        super.empty();

  @override
  bool operator ==(other) {
    return (other is Invoice) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      email: json['email'],
      user: json['user'] != null
          ? AppUser.fromJson(json['user'])
          : AppUser.empty(),
      showTime: json['showTime'] != null
          ? ShowTime.fromJson(json['showTime'])
          : ShowTime.empty(),
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      paymentDate: DateTime.parse(json['paymentDate']),
      tickets: json['tickets'] != null
          ? (json['tickets'] as List)
              .map((e) => Ticket.fromJson(e))
              .toList()
          : [],
      state: GeneralState.values.firstWhere((e) => e.value == json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate:
      DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'user': user.toJson(),
      'showTime': showTime.toJson(),
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentDate': paymentDate.toIso8601String(),
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
