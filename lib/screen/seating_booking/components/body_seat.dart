import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/list_seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/showtime_info.dart';

import '../../../model/show_time.dart';

class BodySeat extends StatefulWidget {
  final ShowTime? showTime;
  final List<Seat> listSeatSelected;

  const BodySeat({Key? key, required this.showTime, required this.listSeatSelected}) : super(key: key);

  @override
  State<BodySeat> createState() => _BodySeatState();
}

class _BodySeatState extends State<BodySeat> {
  setSeat(Seat seat) {
    setState(() {
      if (widget.listSeatSelected.contains(seat)) {
        widget.listSeatSelected.remove(seat);
      } else {
        widget.listSeatSelected.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(25),
        ),
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(1, 18, 45, 1),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 40,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Màn hình".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(30),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    width: 250,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Center(
                      child: Text(
                        "Ghế thường".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    width: 300,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    height: 500,
                    child: Center(
                      child: ListSeat(
                        showtime: widget.showTime,
                        listSeatSelected: widget.listSeatSelected,
                        setSeat: setSeat,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    width: SizeConfig.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Ghế đã đặt",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Ghế đang chọn",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: const Color.fromRGBO(42, 60, 109, 1),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Ghế chưa chọn",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Không được chọn",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ShowtimeInfo(
                showTime: widget.showTime,
                seatsSelected: widget.listSeatSelected,
              ),
            )
          ],
        ));
  }
}
