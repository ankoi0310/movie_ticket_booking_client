import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class CustomFlutterToast {
  FToast fToast;

  static final CustomFlutterToast _instance = CustomFlutterToast._internal();

  factory CustomFlutterToast() {
    return _instance;
  }

  CustomFlutterToast init(BuildContext context) {
    _instance.fToast = fToast.init(context);
    return _instance;
  }

  CustomFlutterToast._internal() : fToast = FToast();

  showToast({required bool success, String message = ''}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        color: success ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(success ? Icons.check : Icons.close, color: Colors.white),
          SizedBox(
            width: getProportionateScreenWidth(12),
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        // top = status bar height + 16.0
        // left = 16.0
        return Positioned(
          top: getProportionateScreenHeight(16),
          right: getProportionateScreenWidth(16),
          child: child,
        );
      },
    );
  }
}
