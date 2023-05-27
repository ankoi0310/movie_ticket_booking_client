import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    Key? key,
    required this.parameters,
  }) : super(key: key);

  final Map<String, String>? parameters;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController = TextEditingController();
  final FocusNode _reTypePasswordFocusNode = FocusNode();
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;

  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  late final CustomFlutterToast toast = CustomFlutterToast();
  late final String token = widget.parameters!['token']!;
  late String password = '';

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  Future<void> resetPassword() async {
    setState(() {
      isSaving = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      HttpResponse response = await _authenticationProvider.resetPassword(
        token: token,
        password: password,
      );

      setState(() {
        isSaving = false;
      });

      toast.showToast(
        success: response.success,
        message: response.message,
      );

      // if (response.success) {
      //   await _appRouterDelegate.setPathName(PublicRouteData.login.name);
      // }
    } else {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenWidth(40),
            bottom: getProportionateScreenWidth(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Cài lại mật khẩu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  'Vui lòng nhập mật khẩu mới của bạn',
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
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                          labelStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return nullPasswordError;
                          return null;
                        },
                        onSaved: (value) => password = value!,
                        onFieldSubmitted: (_) => _reTypePasswordFocusNode.requestFocus(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _reTypePasswordController,
                        focusNode: _reTypePasswordFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          labelStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return nullPasswordError;
                          if (value != _passwordController.text) return notMatchPasswordError;
                          return null;
                        },
                        onFieldSubmitted: (_) async => await resetPassword(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextButton(
                  onPressed: () async => await resetPassword(),
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
                        isSaving ? 'Đang xử lý...' : 'Cài lại mật khẩu',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      if (isSaving) ...[
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
              ],
            ),
          ),
        ),
        Positioned(
          top: getProportionateScreenHeight(20),
          left: getProportionateScreenWidth(-20),
          child: InkWell(
            onTap: () async => await _appRouterDelegate.setPathName(PublicRouteData.home.name),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.arrow_back_sharp,
                    size: 15,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Text(
                  'Trang chủ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: getProportionateScreenHeight(20),
          right: getProportionateScreenWidth(-20),
          child: InkWell(
            onTap: () async => await _appRouterDelegate.setPathName(PublicRouteData.login.name),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                SizedBox(
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    size: 15,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
