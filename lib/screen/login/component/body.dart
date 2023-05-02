import 'package:movie_ticket_booking_flutter_nlu/component/shared/custom_flutter_toast.dart';
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
  final emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  bool remember = false;
  bool _isLoggingIn = false;
  bool _isObscure = true;
  String _email = '', _password = '';

  late CustomFlutterToast toast;

  @override
  void initState() {
    super.initState();
    toast = CustomFlutterToast();
    toast.init(AppRouterDelegate.instance.navigatorKey.currentContext!);
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
    final authProvider = Provider.of<AuthenticationProvider>(context);

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoggingIn = true;
        });

        await authProvider.login(_email, _password).then((response) async {
          if (response.success) {
            _appRouterDelegate.setPathName(PublicRouteData.home.name);
          } else {
            setState(() {
              _isLoggingIn = false;
            });
            toast.showToast(
              success: response.success,
              message: response.message,
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
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        'Chào mừng bạn đến với Starlinex',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        'Đăng nhập để tiếp tục',
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
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Icon(Icons.email),
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
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
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
                              onFieldSubmitted: (value) async => await login(),
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
                                  'Ghi nhớ tài khoản',
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
                              text: 'Quên mật khẩu?',
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isLoggingIn ? 'Đang đăng nhập' : 'Đăng nhập',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionateScreenWidth(18),
                                    ),
                                  ),
                                  if (_isLoggingIn) ...[
                                    SizedBox(width: getProportionateScreenWidth(10)),
                                    SizedBox(
                                      height: getProportionateScreenWidth(20),
                                      width: getProportionateScreenWidth(20),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ]
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        'Hoặc đăng nhập bằng',
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
                            text: 'Bạn chưa có tài khoản? ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenWidth(18),
                            ),
                            children: [
                              TextSpan(
                                text: 'Đăng ký ngay',
                                style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                  fontSize: getProportionateScreenWidth(18),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _appRouterDelegate.setPathName(PublicRouteData.register.name),
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
