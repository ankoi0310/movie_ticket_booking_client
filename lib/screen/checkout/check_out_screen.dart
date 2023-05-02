import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/checkout_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_router_delegate.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/route_handler.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/checkout/components/form_checkout.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/checkout/components/info_checkout.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final String? jsonObject;

  const CheckoutScreen({Key? key, required this.jsonObject}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ShowTime? showTime;
  final Invoice invoice = Invoice.empty();
  final List<Seat> listSeatSelected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map object = jsonDecode(widget.jsonObject!);
    showTime = ShowTime.fromJson(object['showTime']);
    List jsonSeats = object['seatsSelected'];
    listSeatSelected.addAll(jsonSeats.map((e) => Seat.fromJson(e)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const Breadcrumb(
              title: "Thanh toán",
              imageUrl: "assets/image/breadcrumb_movie_screen.png",
              description:
                  "Tất cả các phim đang chiếu và sắp chiếu tại rạp phim Cinema StarLineX Entertainment",
            ),
            Builder(builder: (context) {
              return Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        FormCheckout(
                          formKey: _formKey,
                          invoice: invoice,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // button back
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Quay lại",
                                    style: TextStyle(
                                      fontSize: 17,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              // button confirm
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await checkoutProvider
                                        .createInvoice(invoice);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Tiếp tục",
                                    style: TextStyle(
                                      fontSize: 17,
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                    child: InfoCheckout(
                      showTime: showTime,
                      listSeatSelected: listSeatSelected,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
