import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ResetPasswordField extends StatefulWidget {
  const ResetPasswordField({
    super.key,
  });

  @override
  State<ResetPasswordField> createState() => _ResetPasswordFieldState();
}

class _ResetPasswordFieldState extends State<ResetPasswordField> {
  final AuthenticationService _authenticationService = AuthenticationService.instance;

  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  late final CustomFlutterToast toast = CustomFlutterToast();

  bool isSending = false;

  Future<void> forgotPassword() async {
    setState(() {
      isSending = true;
    });

    String email = await _authenticationService.getCurrentUserEmail();
    HttpResponse response = await _authenticationProvider.forgotPassword(email);

    setState(() {
      isSending = false;
    });

    toast.showToast(
      success: response.success,
      message: response.message,
    );

    if (response.success) {
      _authenticationProvider.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(20)),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Quên mật khẩu? Đặt lại mật khẩu ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: 'tại đây',
                  recognizer: TapGestureRecognizer()..onTap = () async => await forgotPassword(),
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (isSending)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
