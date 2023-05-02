import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/room.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

import '../../../config/size_config.dart';

class ListSeat extends StatefulWidget {
  final Room? room;
  final void Function(List<Seat>) setSeats;

  ListSeat({Key? key, required this.room, required this.setSeats})
      : super(key: key);

  @override
  State<ListSeat> createState() => _ListSeatState();
}

class _ListSeatState extends State<ListSeat> {
  List<Seat> seatsSelected = [];
  List<String> listRowAlphabet = [];

  final scrollController = ScrollController();

  // @override
  void initListRowAlphabet() {
    listRowAlphabet = [];
    for (int i = 0; i < widget.room!.row; i++) {
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
              widget.room!.row,
              (indexRow) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(widget.room!.col, (indexCol) {
                      Seat seat = widget.room!.seats
                          .where((element) =>
                              element.row == indexRow &&
                              element.col == indexCol + 1)
                          .first;
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
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  seatsSelected.contains(seat)
                                      ? seatsSelected.remove(seat)
                                      : seatsSelected.add(seat);
                                  widget.setSeats(seatsSelected);
                                });
                              },
                              child: HoverBuilder(builder: (isHovering) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: isHovering ||
                                            seatsSelected.contains(seat)
                                        ? Colors.green
                                        : const Color.fromRGBO(42, 60, 109, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      seat.code,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionateScreenWidth(15),
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
