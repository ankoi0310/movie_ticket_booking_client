import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_input_form_field.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String fullName = '', email = '', phone = '', birthday = '', password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode retypePasswordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();

    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    birthdayFocusNode.dispose();
    passwordFocusNode.dispose();
    retypePasswordFocusNode.dispose();
    super.dispose();
  }

  void register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: buildMobileBody(context),
      tablet: buildMobileBody(context),
      desktop: buildDesktopBody(context),
    );
  }

  Container buildMobileBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
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
                controller: fullNameController,
                focusNode: fullNameFocusNode,
                validator: (value) {
                  if (value.isEmpty) return nullNameError;
                  return null;
                },
                onFieldSubmitted: (value) {
                  emailFocusNode.requestFocus();
                },
              ),
              buildInputFormField(
                title: 'Email',
                icon: const Icon(Icons.email),
                obscureText: false,
                controller: emailController,
                focusNode: emailFocusNode,
                validator: (value) {
                  if (value.isEmpty) return nullEmailError;
                  if (!AppUtil.isValidEmail(value)) return invalidEmailError;
                  return null;
                },
                onFieldSubmitted: (value) {
                  phoneFocusNode.requestFocus();
                },
              ),
              buildInputFormField(
                title: 'Phone',
                icon: const Icon(Icons.phone),
                obscureText: false,
                controller: phoneController,
                focusNode: phoneFocusNode,
                validator: (value) {
                  if (value.isEmpty) return nullPhoneError;
                  return null;
                },
                onFieldSubmitted: (value) {
                  birthdayFocusNode.requestFocus();
                },
              ),
              buildInputFormField(
                title: 'Birthday',
                icon: const Icon(Icons.calendar_today),
                obscureText: false,
                controller: birthdayController,
                focusNode: birthdayFocusNode,
                validator: (value) {
                  if (value.isEmpty) return nullBirthdayError;
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
                  if (value.isEmpty) return nullPasswordError;
                  if (AppUtil.isShortPassword(value)) return shortPasswordError;
                  return null;
                },
                onFieldSubmitted: (value) {
                  retypePasswordFocusNode.requestFocus();
                },
              ),
              buildInputFormField(
                title: 'Re-type Password',
                icon: const Icon(Icons.lock),
                obscureText: true,
                controller: retypePasswordController,
                focusNode: retypePasswordFocusNode,
                validator: (value) {
                  if (value.isEmpty) return nullRetypePasswordError;
                  if (passwordController.text != retypePasswordController.text) return notMatchPasswordError;
                  return null;
                },
                onFieldSubmitted: (value) {
                  register(context);
                },
              ),
              const SizedBox(height: (20)),
              CustomButton(
                title: 'Create Account',
                width: double.infinity,
                height: (50),
                onPressed: () => register(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildDesktopBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputFormField(
                        title: 'Full Name',
                        icon: const Icon(Icons.person),
                        obscureText: false,
                        controller: fullNameController,
                        focusNode: fullNameFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return nullNameError;
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          emailFocusNode.requestFocus();
                        },
                      ),
                      buildInputFormField(
                        title: 'Email',
                        icon: const Icon(Icons.email),
                        obscureText: false,
                        controller: emailController,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return nullEmailError;
                          if (!AppUtil.isValidEmail(value)) return invalidEmailError;
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          phoneFocusNode.requestFocus();
                        },
                      ),
                      buildInputFormField(
                        title: 'Phone',
                        icon: const Icon(Icons.phone),
                        obscureText: false,
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return nullPhoneError;
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          birthdayFocusNode.requestFocus();
                        },
                      ),
                      buildInputFormField(
                        title: 'Birthday',
                        icon: const Icon(Icons.calendar_today),
                        obscureText: false,
                        controller: birthdayController,
                        focusNode: birthdayFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return nullBirthdayError;
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
                          if (value.isEmpty) return nullPasswordError;
                          if (value.length < 8) return shortPasswordError;
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          retypePasswordFocusNode.requestFocus();
                        },
                      ),
                      buildInputFormField(
                        title: 'Re-type Password',
                        icon: const Icon(Icons.lock),
                        obscureText: true,
                        controller: retypePasswordController,
                        focusNode: retypePasswordFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return nullRetypePasswordError;
                          if (passwordController.text != retypePasswordController.text) return notMatchPasswordError;
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          register(context);
                        },
                      ),
                      const SizedBox(height: (20)),
                      CustomButton(
                        title: 'Create Account',
                        width: double.infinity,
                        height: (50),
                        onPressed: () => register(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}