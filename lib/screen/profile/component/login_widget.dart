import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_input_form_field.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/constants.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/profile_screen.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String email = '', password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInputFormField(
                title: 'Full Name',
                icon: const Icon(Icons.person),
                obscureText: false,
                controller: emailController,
                focusNode: emailFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return kEmailNullError;
                  }

                  if (!emailValidatorRegExp.hasMatch(value)) {
                    return kInvalidEmailError;
                  }

                  return null;
                },
                onFieldSubmitted: (value) {
                  passwordFocusNode.requestFocus();
                },
              ),
              buildInputFormField(
                title: 'Password',
                icon: const Icon(Icons.lock),
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return kPassNullError;
                  }

                  return null;
                },
                onFieldSubmitted: (value) {
                  login(context);
                },
              ),
              SizedBox(height: (20)),
              CustomButton(
                title: 'Đăng nhập',
                width: double.infinity,
                height: (50),
                onPressed: () => login(context),
              ),
            ],
          ),
        ),
      ),
    );
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
}
