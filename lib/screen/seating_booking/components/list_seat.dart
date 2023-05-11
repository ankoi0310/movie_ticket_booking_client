import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/room.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/ticket.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

import '../../../config/size_config.dart';

class ListSeat extends StatefulWidget {
  final ShowTime? showtime;
  final List<Seat> listSeatSelected;
  final void Function(Seat) setSeat;

  ListSeat({Key? key, required this.showtime, required this.listSeatSelected, required this.setSeat}) : super(key: key);

  @override
  State<ListSeat> createState() => _ListSeatState();
}

class _ListSeatState extends State<ListSeat> {
  List<String> listRowAlphabet = [];
  late final Room room;
  Set<Ticket> tickets = {};

  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    room = widget.showtime!.room!;

    widget.showtime!.invoices.where(
            (invoice) => invoice.paymentStatus == PaymentStatus.success)
        .toList().forEach((invoice) {
      invoice.tickets.forEach((ticket) {
        tickets.add(ticket);
      });
    });
  }

  // @override
  void initListRowAlphabet() {
    listRowAlphabet = [];
    for (int i = 0; i < widget.showtime!.room!.row; i++) {
      listRowAlphabet.add(String.fromCharCode(65 + i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              room.row,
              (indexRow) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(room.col, (indexCol) {
                      Seat seat = room.seats.where((element) => element.row - 1 == indexRow && element.col == indexCol + 1).first;
                      if (seat.isSeat) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Builder(builder: (context) {
                            return tickets.map((e) => e.seat).contains(seat)
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        seat.code,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getProportionateScreenWidth(15),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.setSeat(seat);
                                      });
                                    },
                                    child: HoverBuilder(builder: (isHovering) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: isHovering || widget.listSeatSelected.contains(seat) ? Colors.green : const Color.fromRGBO(42, 60, 109, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            seat.code,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: getProportionateScreenWidth(15),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                          }),
                        );
                      } else {
                        return Container(
                          color: Colors.transparent,
                          width: 20,
                          height: 20,
                        );
                      }
                    }),
                  )),
        ),
      ),
    );
  }
}
