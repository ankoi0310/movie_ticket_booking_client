import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/shared/social_icon_tile.dart';
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
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final birthDayFocusNode = FocusNode();

  bool remember = false;
  bool _isRegistering = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    nameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    birthDayFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final userRegister = UserRegister.empty();

    Future<void> register() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isRegistering = true;
        });

        await authProvider.register(userRegister).then((response) async {
          if (response.success) {
            // _appRouterDelegate.setPathName(PublicRouteData.home.name);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký thành công'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            setState(() {
              _isRegistering = false;
            });
            print(response.message);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Đăng ký không thành công'),
            //     backgroundColor: Colors.red,
            //   ),
            // );
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
                      horizontal: getProportionateScreenWidth(40)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        'Đăng ký tài khoản',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              focusNode: nameFocusNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                labelText: 'Họ và tên',
                                labelStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return nullNameError;
                                return null;
                              },
                              onSaved: (value) {
                                userRegister.name = value!;
                              },
                              onFieldSubmitted: (value) {
                                emailFocusNode.requestFocus();
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
                              focusNode: emailFocusNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return nullEmailError;
                                if (!AppUtil.isValidEmail(value))
                                  return invalidEmailError;
                                return null;
                              },
                              onSaved: (value) {
                                userRegister.email = value!;
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  labelText: 'Mật khẩu',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) return nullPasswordError;
                                if (AppUtil.isShortPassword(value))
                                  return shortPasswordError;
                                return null;
                              },
                              onSaved: (value) {
                                userRegister.password = value!;
                              },
                              onFieldSubmitted: (value) {
                                confirmPasswordFocusNode.requestFocus();
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
                              focusNode: confirmPasswordFocusNode,
                              obscureText: _isObscure,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return nullRetypePasswordError;
                                if (value != userRegister.password)
                                  return notMatchPasswordError;
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                phoneFocusNode.requestFocus();
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
                              focusNode: phoneFocusNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  labelText: 'Số điện thoại',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Icon(Icons.phone)),
                              validator: (value) {
                                if (value!.isEmpty) return nullPhoneError;
                                if (!AppUtil.isValidPhone(value))
                                  return invalidPhoneError;
                                return null;
                              },
                              onSaved: (value) {
                                userRegister.phone = value!;
                              },
                              onFieldSubmitted: (value) {
                                birthDayFocusNode.requestFocus();
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
                              focusNode: birthDayFocusNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  labelText: 'Ngày sinh',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Icon(Icons.calendar_today)),
                              validator: (value) {
                                if (value!.isEmpty) return nullBirthdayError;
                                return null;
                              },
                              onChanged: (value) {
                                if (value.length == 2) {
                                  value += '/';
                                } else if (value.length == 5) {
                                  value += '/';
                                }
                              },
                              onSaved: (value) {
                                userRegister.birthday =
                                    DateFormat('dd/MM/yyyy').parse(value!);
                              },
                              onFieldSubmitted: (value) async =>
                                  await register(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
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
                                const Text('Remember me'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
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
                        onTap: () async => await register(),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isRegistering
                                      ? 'Đang đăng ký...'
                                      : 'Đăng ký',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionateScreenWidth(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_isRegistering) ...[
                                  SizedBox(
                                      width: getProportionateScreenWidth(10)),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                    width: getProportionateScreenWidth(20),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        'Hoặc đăng ký bằng',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18)),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.from(
                          loginSocicalIcons.map((socialIcon) =>
                              SocialIconTile(socialIcon: socialIcon)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(20),
                          horizontal: getProportionateScreenWidth(20),
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: 'Bạn đã có tài khoản? ',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18)),
                            children: [
                              TextSpan(
                                text: 'Đăng nhập',
                                style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                  fontSize: getProportionateScreenWidth(18),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _appRouterDelegate
                                      .setPathName(PublicRouteData.login.name),
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
}
