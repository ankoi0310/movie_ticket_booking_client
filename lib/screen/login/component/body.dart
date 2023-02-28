import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom/social_icon_tile.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/constants.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/profile_screen.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/register/register_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool remember = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(), passwordController = TextEditingController();
  final emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đang đăng nhập...'),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập thành công!'),
          ),
        );

        Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color(0xFF8A2387),
            // Color(0xFFE94057),
            // Color(0xFFF27121),
            kPrimaryColor,
            kSecondaryDarkColor,
            // kBackgroundLightColor,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(30),
            bottom: getProportionateScreenHeight(60),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('image/logo.png'),
              SizedBox(height: getProportionateScreenHeight(30)),
              Container(
                width: SizeConfig.screenWidth * 0.25,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(40),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(35),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      'Please login to your account',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      children: [
                        Flexible(
                          child: buildTextFormField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) return kEmailNullError;
                              if (!emailValidatorRegExp.hasMatch(value)) return kInvalidEmailError;
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              passwordFocusNode.requestFocus();
                            },
                            obscureText: false,
                            labelText: 'Email',
                            suffixIcon: FontAwesomeIcons.envelope,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      children: [
                        Flexible(
                          child: buildTextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) return kPassNullError;
                              if (value.length < 8) return kShortPassError;
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              login(context);
                            },
                            obscureText: true,
                            labelText: 'Password',
                            suffixIcon: FontAwesomeIcons.lock,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
                          child: Row(
                            children: [
                              Checkbox(
                                value: remember,
                                onChanged: (value) {
                                  setState(() {
                                    remember = value!;
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: kPrimaryColor,
                                side: const BorderSide(color: Colors.grey),
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
                          child: Text.rich(TextSpan(
                            text: 'Forgot Password?',
                            style: TextStyle(
                              color: Colors.orangeAccent[700],
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                              },
                          )),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF8A2387),
                              Color(0xFFE94057),
                              Color(0xFFF27121),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Text(
                      'Or connect using',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getProportionateScreenWidth(18),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.from(
                        loginSocicalIcons.map((socialIcon) => SocialIconTile(socialIcon: socialIcon)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20),
                        horizontal: getProportionateScreenWidth(20),
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: getProportionateScreenWidth(18),
                          ),
                          children: [
                            TextSpan(
                              text: 'Register Now',
                              style: TextStyle(
                                color: Colors.orangeAccent[700],
                                fontSize: getProportionateScreenWidth(18),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(context, RegisterScreen.routeName),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? Function(String?) validator,
    required void Function(String?) onFieldSubmitted,
    required bool obscureText,
    required String labelText,
    required IconData suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      cursorHeight: getProportionateScreenHeight(25),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: Icon(
          suffixIcon,
          size: getProportionateScreenWidth(17),
          color: Colors.grey,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
