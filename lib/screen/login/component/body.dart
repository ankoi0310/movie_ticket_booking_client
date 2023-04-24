import 'package:movie_ticket_booking_flutter_nlu/component/social_icon_tile.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  bool remember = false;
  bool _isLoggingIn = false;
  bool _isObscure = true;
  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();
    emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoggingIn = true;
        });

        await authProvider.login(_email, _password).then((success) async {
          if (success) {
            _appRouterDelegate.setPathName(RouteData.home.name);
          } else {
            setState(() {
              _isLoggingIn = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng nhập thất bại'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      }
    }

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
              Form(
                key: _formKey,
                child: Container(
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
                            child: TextFormField(
                              focusNode: emailFocusNode,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              cursorHeight: getProportionateScreenHeight(20),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                floatingLabelAlignment: FloatingLabelAlignment.start,
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return nullEmailError;
                                if (!AppUtil.isValidEmail(value)) return invalidEmailError;
                                return null;
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                              onFieldSubmitted: (value) {
                                passwordFocusNode.requestFocus();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              focusNode: passwordFocusNode,
                              obscureText: _isObscure,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.black,
                              cursorHeight: getProportionateScreenHeight(20),
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return nullPasswordError;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              onFieldSubmitted: (value) {
                                login();
                              },
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
                        onTap: () async => await login(),
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
                                recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, RegisterScreen.routeName),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
