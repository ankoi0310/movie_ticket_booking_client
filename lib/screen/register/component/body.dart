import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/component/register_form.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/component/register_success.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isRegisterSuccess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/logo.png', width: 150),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              width: SizeConfig.screenWidth * 0.4,
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isRegisterSuccess
                  ? const RegisterSuccess()
                  : RegisterForm(
                      onSuccess: () {
                        setState(() {
                          _isRegisterSuccess = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
