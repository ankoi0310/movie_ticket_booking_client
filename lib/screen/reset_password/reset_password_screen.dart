import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/reset_password/component/body.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.parameters,
  }) : super(key: key);

  final Map<String, String>? parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(parameters: parameters),
    );
  }
}
