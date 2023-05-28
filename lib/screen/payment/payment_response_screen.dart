import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/payment/payment_momo_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/checkout_provider.dart';

class PaymentResponseScreen extends StatefulWidget {
  final PaymentMomoResponse? paymentResponse;
  const PaymentResponseScreen({Key? key, required this.paymentResponse}) : super(key: key);

  @override
  State<PaymentResponseScreen> createState() => _PaymentResponseScreenState();
}

class _PaymentResponseScreenState extends State<PaymentResponseScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
    checkoutProvider.returnMomo(widget.paymentResponse!);
    print('PaymentResponseScreen: ${widget.paymentResponse!.orderId}');
  }

  @override
  Widget build(BuildContext context) {
    Widget buildResponseSuccess() {

      return Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Text(
            'Thanh toán thành công',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Mã đơn hàng: ${widget.paymentResponse!.orderId}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Cảm ơn bạn đã mua vé',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              AppRouterDelegate().setPathName(PublicRouteData.home.name);
            },
            child: const Text('Quay về trang chủ'),
          ),
        ],
      );
    }

    Widget buildResponseFailed() {
      return Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'Thanh toán thất bại',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 100,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Có lỗi xảy ra trong quá trình thanh toán',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Quay về trang chủ'),
          ),
        ],
      );
    }

    return SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
      child: widget.paymentResponse?.resultCode == 0?buildResponseSuccess(): buildResponseFailed(),
    ),
        ));
  }
}
