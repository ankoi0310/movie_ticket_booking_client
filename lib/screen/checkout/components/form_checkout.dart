import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/invoice/invoice_create.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice_combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/utilities/StringUtil.dart';
import 'package:quantity_input/quantity_input.dart';

class FormCheckout extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final InvoiceCreate invoice;
  final List<Combo> combos;
  final Function(InvoiceCombo) setCombo;

  const FormCheckout({Key? key, required this.formKey, required this.invoice, required this.combos, required this.setCombo}) : super(key: key);

  @override
  State<FormCheckout> createState() => _FormCheckoutState();
}

class _FormCheckoutState extends State<FormCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 25,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Họ và tên",
                hintText: "Nhập họ và tên",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "Vui lòng nhập họ và tên";
              //   }
              //   return null;
              // },
              onChanged: (value) {
                widget.invoice.name = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Nhập email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "Vui lòng nhập email";
              //   }
              //   return null;
              // },
              onChanged: (value) {
                widget.invoice.email = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Phương thức thanh toán",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RadioListTile<String>(
              title: const Text('Momo'),
              value: PaymentMethod.momo.value,
              groupValue: widget.invoice.paymentMethod,
              onChanged: (value) {
                setState(() {
                  widget.invoice.paymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('VnPay'),
              value: PaymentMethod.vnPay.value,
              groupValue: widget.invoice.paymentMethod,
              onChanged: (value) {
                setState(() {
                  widget.invoice.paymentMethod = value!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Combo khuyến mãi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.combos.length, (index) {
                  Combo combo = widget.combos[index];
                  InvoiceCombo invoiceCombo = widget.invoice.invoiceCombos.firstWhere((element) => element.combo?.id == combo.id,
                      orElse: () => InvoiceCombo.initial(combo: combo, invoice: null, quantity: 0));

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              // image: DecorationImage(
                              //   image: ,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  combo.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  StringUtil.changeToDescriptionCombo(combo),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: QuantityInput(
                                value: invoiceCombo.quantity,
                                maxValue: 10,
                                acceptsNegatives: false,
                                type: QuantityInputType.int,
                                minValue: 0,
                                acceptsZero: true,
                                step: 1,
                                onChanged: (value) {
                                  setState(() {
                                    invoiceCombo.quantity = int.parse(value.toString());
                                    widget.setCombo(invoiceCombo);
                                  });
                                })),
                        Expanded(
                          flex: 2,
                          child: Text(
                            NumberFormat.currency(locale: 'vi').format(combo.price),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
