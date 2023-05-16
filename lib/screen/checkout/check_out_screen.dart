import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/Combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice_combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/invoice/invoice_create.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/checkout_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/combo_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/loading_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/route/app_router_delegate.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/checkout/components/form_checkout.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/checkout/components/info_checkout.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  final String? jsonObject;

  const CheckoutScreen({Key? key, required this.jsonObject}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ShowTime? showTime;
    final InvoiceCreate invoiceCreate = InvoiceCreate.empty();
  final List<Seat> listSeatSelected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map object = jsonDecode(widget.jsonObject!);
    showTime = ShowTime.fromJson(object['showTime']);
    List jsonSeats = object['seatsSelected'];
    listSeatSelected.addAll(jsonSeats.map((e) => Seat.fromJson(e)).toList());

    invoiceCreate.showtime = showTime!;
    invoiceCreate.seats = listSeatSelected;
  }

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final appRouterDelegate = AppRouterDelegate.instance;
    final comboProvider = Provider.of<ComboProvider>(context, listen: false);



    int totalPrice() {
      int totalPrice = 0;
      totalPrice += showTime!.price * listSeatSelected.length;
      invoiceCreate.invoiceCombos.forEach((element) {
        totalPrice += element.combo!.price * element.quantity;
      });
      return totalPrice;
    }

    Future<void> checkout(InvoiceCreate invoice) async {
      loadingProvider.setLoading(true);

      invoiceCreate.totalPrice = totalPrice();

      HttpResponse response = await checkoutProvider.createInvoice(invoice);
      MomoResponse momoResponse = MomoResponse.fromJson(response.data);
      if (momoResponse.resultCode == 0) {
        if (await canLaunchUrl(Uri.parse(momoResponse.payUrl))) {
          loadingProvider.setLoading(false);
          await launchUrl(Uri.parse(momoResponse.payUrl));
        } else {
          loadingProvider.setLoading(false);
          throw 'Could not launch ${momoResponse.payUrl}';
        }
      } else {}
    }

    setCombo(InvoiceCombo combo) {
      setState(() {
          invoiceCreate.invoiceCombos.add(combo);
      });
    }

    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            const Breadcrumb(
              title: "Thanh toán",
              imageUrl: "assets/image/breadcrumb_movie_screen.png",
              description: "Tất cả các phim đang chiếu và sắp chiếu tại rạp phim Cinema StarLineX Entertainment",
            ),
            Builder(
              builder: (context) {
                return FutureBuilder(
                    future: comboProvider.getCombos(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    children: [
                                      FormCheckout(
                                        formKey: _formKey,
                                        invoice: invoiceCreate,
                                        combos: comboProvider.combos,
                                          setCombo: setCombo,
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
                                                appRouterDelegate.setPathName(PublicRouteData.seat.name,
                                                    json: jsonEncode({
                                                      'showtime': showTime!.toJson(),
                                                      'listSeatSelected': listSeatSelected.map((e) => e.toJson()).toList(),
                                                    }));
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
                                                child: const Text(
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
                                                  await checkout(invoiceCreate);
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
                                                child: const Text(
                                                  "Thanh toán",
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
                                    comboInvoices: invoiceCreate.invoiceCombos,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    });
              }
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
