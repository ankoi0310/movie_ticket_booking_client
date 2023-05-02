import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/firebase_storage_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/utilities/StringUtil.dart';
import 'package:provider/provider.dart';

class InfoCheckout extends StatefulWidget {
  final ShowTime? showTime;
  final List<Seat> listSeatSelected;
  const InfoCheckout({Key? key, required this.showTime, required this.listSeatSelected}) : super(key: key);

  @override
  State<InfoCheckout> createState() => _InfoCheckoutState();
}

class _InfoCheckoutState extends State<InfoCheckout> {
  @override
  Widget build(BuildContext context) {
    final firebaseStorageProvider =
    Provider.of<FirebaseStorageProvider>(context);



    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 12,
          child: Container(
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: firebaseStorageProvider
                        .getImages([widget.showTime!.movie!.imageHorizontal]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: Image.memory(
                                    firebaseStorageProvider.mapImage[widget
                                        .showTime!.movie!.imageHorizontal]!)
                                    .image,
                                fit: BoxFit.fill,
                              )),
                        );
                      } else {
                        return Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ));
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.showTime!.movie!.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Rạp: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.showTime!.room!.branch.name} | ${widget.showTime!.room!.name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Suất chiếu: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(widget.showTime!.startTime!)} | ${DateFormat('HH:mm').format(widget.showTime!.startTime!)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ghế: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      child: Text(
                        widget.listSeatSelected
                            .map((e) => e.code)
                            .toList()
                            .join(", "),
                        textAlign: TextAlign.start,
                        softWrap: true,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          letterSpacing: 2,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hình thức: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      StringUtil.changeMovieFormat(widget.showTime!.movieFormat),
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng giá: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${widget.showTime!.price * widget.listSeatSelected.length} VND",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(26),
                        letterSpacing: 2,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
