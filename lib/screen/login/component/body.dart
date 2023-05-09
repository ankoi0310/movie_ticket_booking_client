import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

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
          setState(() {
            _isLoggingIn = false;
          });

          if (response.success) {
            _appRouterDelegate.setPathName(PublicRouteData.home.name);
          } else {
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
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            accentColor,
            primaryColor,
            accentColor,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('image/logo.png', width: 150),
              SizedBox(height: getProportionateScreenHeight(30)),
              Form(
                key: _formKey,
                child: Container(
                  width: SizeConfig.screenWidth * 0.25,
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(30)),
                      const Text(
                        'Chào mừng bạn đến với Starlinex',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        'Đăng nhập để tiếp tục',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              focusNode: emailFocusNode,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).colorScheme.secondary,
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
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).colorScheme.secondary,
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
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  remember = !remember;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: remember,
                                    onChanged: (value) {},
                                    checkColor: Colors.white,
                                    activeColor: primaryColor,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                  const Text('Ghi nhớ tài khoản'),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
                            child: HoverBuilder(
                              builder: (isHovering) {
                                return Text.rich(
                                  TextSpan(
                                    text: 'Quên mật khẩu?',
                                    style: TextStyle(
                                      color: isHovering ? Theme.of(context).colorScheme.primary : Colors.grey,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                                      },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async => await login(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(20),
                            horizontal: getProportionateScreenWidth(10),
                          ),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLoggingIn ? 'Đang đăng nhập' : 'Đăng nhập',
                              style: const TextStyle(fontSize: 18, color: Colors.white),
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
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(height: 10),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Hoặc đăng nhập bằng',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(height: 10),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.from(
                          socialIcons.map((socialIcon) => SocialIconTile(socialIcon: socialIcon)),
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
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Đăng ký ngay',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () => _appRouterDelegate.setPathName(PublicRouteData.register.name),
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
