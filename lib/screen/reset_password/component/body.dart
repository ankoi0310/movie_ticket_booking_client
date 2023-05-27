import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/reset_password/component/reset_password_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.parameters,
  }) : super(key: key);

  final Map<String, String>? parameters;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            accentColor,
            primaryColor,
            accentColor,
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/logo.png', width: 150),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              width: SizeConfig.screenWidth * 0.25,
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ResetPasswordForm(parameters: parameters),
            ),
          ],
        ),
      ),
    );
  }
}
