import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ForgotPasswordField extends StatefulWidget {
  const ForgotPasswordField({
    Key? key,
    required this.goBack,
  }) : super(key: key);

  final VoidCallback goBack;

  @override
  State<ForgotPasswordField> createState() => _ForgotPasswordFieldState();
}

class _ForgotPasswordFieldState extends State<ForgotPasswordField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

  late final CustomFlutterToast toast = CustomFlutterToast();

  bool isSending = false;
  String email = '';

  Future<void> forgotPassword() async {
    setState(() {
      isSending = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      HttpResponse response = await _authenticationProvider.forgotPassword(email);

      setState(() {
        isSending = false;
      });

      toast.showToast(
        success: response.success,
        message: response.message,
      );
    } else {
      setState(() {
        isSending = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    toast.init(context);
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
                  'Quên mật khẩu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  'Vui lòng nhập email để cài lại mật khẩu',
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
                        initialValue: email,
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
                          email = value!;
                        },
                        onFieldSubmitted: (value) async => await forgotPassword(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextButton(
                  onPressed: () async => await forgotPassword(),
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
                        isSending ? 'Đang gửi...' : 'Gửi',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      if (isSending) ...[
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
            onTap: widget.goBack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.keyboard_backspace_sharp,
                    size: 15,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Text(
                  'Quay lại',
                  style: TextStyle(
                    fontSize: 15,
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
