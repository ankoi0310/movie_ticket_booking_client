import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.onForgotPassword,
  }) : super(key: key);

  final VoidCallback onForgotPassword;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();
  late final AuthenticationProvider authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  late final CustomFlutterToast toast = CustomFlutterToast();

  String _email = '', _password = '';
  bool _isLoggingIn = false, _isObscure = true, _remember = false;
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

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

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  Future<void> loginFacebook() async {
    final LoginResult result = await FacebookAuth.i.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final LoginResult result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login"),
        content: Text(result.status.toString()),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
      ),
    );
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  @override
  void initState() {
    super.initState();
    toast.init(_appRouterDelegate.navigatorKey.currentContext!);
    // _checkIfIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
                        _remember = !_remember;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          value: _remember,
                          onChanged: (value) {},
                          checkColor: Colors.white,
                          activeColor: primaryColor,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashRadius: 0,
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
                          recognizer: TapGestureRecognizer()..onTap = widget.onForgotPassword,
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
              children: [
                FlutterSocialButton(
                  onTap: loginFacebook,
                  mini: true,
                  buttonType: ButtonType.facebook, // Button type for different type buttons
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text.rich(
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
          ],
        ),
      ),
    );
  }
}
