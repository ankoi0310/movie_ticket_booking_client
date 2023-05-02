import 'dart:core';

import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';

enum TicketStatus {
  booked("BOOKED"),
  cancelled("CANCELLED"),
  used("USED");

  final String value;

  const TicketStatus(this.value);

  factory TicketStatus.fromValue(String value) {
    return TicketStatus.values.firstWhere((e) => e.value == value);
  }
}

class Ticket extends General {
  String code;
  ShowTime showTime;
  Seat seat;
  TicketStatus status;

  Ticket({
    required int id,
    required this.code,
    required this.showTime,
    required this.seat,
    required this.status,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
          id: id,
          state: state,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          deletedDate: deletedDate,
        );

  Ticket.empty()
      : code = '',
        showTime = ShowTime.empty(),
        seat = Seat.empty(),
        status = TicketStatus.booked,
        super.empty();

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      code: json['code'],
      showTime: ShowTime.fromJson(json['showTime']),
      seat: Seat.fromJson(json['seat']),
      status: TicketStatus.fromValue(json['status']),
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'showTime': showTime.toJson(),
    'seat': seat.toJson(),
    'status': status.value,
    'state': state.value,
    'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
    'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
    'deletedDate': deletedDate != null
        ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
        : null,
  };
}
