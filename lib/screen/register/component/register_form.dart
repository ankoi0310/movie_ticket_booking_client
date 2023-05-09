import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/social_icon.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  final VoidCallback onSuccess;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode birthDayFocusNode = FocusNode();

  bool remember = false;
  bool _isRegistering = false;
  bool _isObscure = true;

  late CustomFlutterToast toast;

  @override
  void initState() {
    super.initState();
    toast = CustomFlutterToast();
    toast.init(AppRouterDelegate.instance.navigatorKey.currentContext!);
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
          setState(() {
            _isRegistering = false;
          });

          if (response.success) {
            widget.onSuccess();
          } else {
            toast.showToast(
              success: response.success,
              message: response.message,
            );
          }
        });
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          const Text(
            'Đăng ký tài khoản',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextFormField(
                  focusNode: nameFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    labelStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
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
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 5,
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
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: _passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: _isObscure,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Focus(
                        descendantsAreFocusable: false,
                        canRequestFocus: false,
                        child: IconButton(
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
                      )),
                  validator: (value) {
                    if (value!.isEmpty) return nullPasswordError;
                    if (AppUtil.isShortPassword(value)) return shortPasswordError;
                    return null;
                  },
                  onSaved: (value) {
                    userRegister.password = value;
                  },
                  onFieldSubmitted: (value) {
                    confirmPasswordFocusNode.requestFocus();
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: TextFormField(
                  focusNode: confirmPasswordFocusNode,
                  obscureText: _isObscure,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu',
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Focus(
                        descendantsAreFocusable: false,
                        canRequestFocus: false,
                        child: IconButton(
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
                      )),
                  validator: (value) {
                    if (value!.isEmpty) return nullRetypePasswordError;
                    if (value != _passwordController.text) return notMatchPasswordError;
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
              Expanded(
                flex: 7,
                child: TextFormField(
                  focusNode: phoneFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return nullPhoneError;
                    if (!AppUtil.isValidPhone(value)) return invalidPhoneError;
                    return null;
                  },
                  onSaved: (value) {
                    userRegister.phone = value;
                  },
                  onFieldSubmitted: (value) {
                    birthDayFocusNode.requestFocus();
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: _birthDayController,
                  focusNode: birthDayFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Ngày sinh',
                    labelStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return nullBirthdayError;
                    if (!AppUtil.isValidBirthday(value)) return invalidBirthdayError;
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length == 2) _birthDayController.text = '$value/';
                    if (value.length == 5) _birthDayController.text = '$value/';
                    _birthDayController.selection = TextSelection.fromPosition(TextPosition(offset: _birthDayController.text.length));
                  },
                  onSaved: (value) {
                    userRegister.birthday = DateFormat('dd/MM/yyyy').parse(value!);
                  },
                  onFieldSubmitted: (value) async => await register(),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(text: 'Bằng cách nhấn vào đăng ký, bạn đồng ý với '),
                TextSpan(
                  text: 'Điều khoản dịch vụ',
                  style: const TextStyle(color: primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' và '),
                TextSpan(
                  text: 'Chính sách bảo mật',
                  style: const TextStyle(color: primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' của chúng tôi.'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(30)),
            child: HoverBuilder(
              builder: (isHovering) {
                return TextButton(
                  onPressed: () async => await register(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(20),
                      horizontal: getProportionateScreenWidth(10),
                    ),
                    backgroundColor: isHovering ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isRegistering ? 'Đang đăng ký' : 'Đăng ký',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      if (_isRegistering) ...[
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
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(indent: getProportionateScreenWidth(20)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
                child: const Text(
                  'Hoặc đăng nhập bằng',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  endIndent: getProportionateScreenWidth(20),
                ),
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
                text: 'Bạn đã có tài khoản? ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(
                    text: 'Đăng nhập',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () => _appRouterDelegate.setPathName(PublicRouteData.login.name),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
