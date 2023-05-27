import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/login/component/forgot_password_form.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/login/component/login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  bool isForgotPassword = false;

  @override
  void initState() {
    super.initState();
  }

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
              child: isForgotPassword
                  ? ForgotPasswordField(goBack: () {
                      setState(() {
                        isForgotPassword = false;
                      });
                    })
                  : LoginForm(onForgotPassword: () {
                      setState(() {
                        isForgotPassword = true;
                      });
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
