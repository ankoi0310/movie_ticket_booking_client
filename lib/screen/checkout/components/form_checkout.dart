import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/invoice.dart';

class FormCheckout extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Invoice invoice;

  const FormCheckout({Key? key, required this.formKey, required this.invoice})
      : super(key: key);

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
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Họ và tên",
                hintText: "Nhập họ và tên",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập họ và tên";
                }
                return null;
              },
              onSaved: (value) {
                widget.invoice.name = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Nhập email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập email";
                }
                return null;
              },
              onSaved: (value) {
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
              value: PaymentMethod.momo.name,
              groupValue: widget.invoice.paymentMethod,
              onChanged: (value) {
                setState(() {
                  widget.invoice.paymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('VnPay'),
              value: PaymentMethod.vnPay.name,
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
          ],
        ),
      ),
    );
  }
}
