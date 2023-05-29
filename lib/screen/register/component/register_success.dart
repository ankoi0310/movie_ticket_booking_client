import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  late final CustomFlutterToast _toast = CustomFlutterToast();

  final TextEditingController _emailController = TextEditingController();

  Future<void> resendVerifyMail() async {
    HttpResponse response = await _authenticationProvider.resendVerifyMail(_emailController.text);

    _toast.showToast(
      success: response.success,
      message: response.message,
    );
  }

  @override
  void initState() {
    super.initState();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Đăng ký tài khoản thành công'.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          const Text(
            'Vui lòng kiểm tra email để kích hoạt tài khoản.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
            child: Divider(
              color: Colors.black,
              thickness: 1,
              indent: getProportionateScreenWidth(50),
              endIndent: getProportionateScreenWidth(50),
            ),
          ),
          const Text('Chưa nhận được email? Vui lòng kiểm tra hộp thư rác hoặc gửi lại mã kích hoạt.'),
          SizedBox(height: getProportionateScreenHeight(20)),
          Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập email của bạn',
                    suffixIcon: SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async => await resendVerifyMail(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor: secondaryColor,
                        ),
                        child: const Text('Gửi lại mã kích hoạt'),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    hoverColor: accentColor,
                    onTap: () {
                      AppRouterDelegate.instance.setPathName(PublicRouteData.home.name);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_sharp),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text('Trở về trang chủ'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppRouterDelegate.instance.setPathName(PublicRouteData.login.name);
                    },
                    hoverColor: accentColor,
                    highlightColor: accentColor,
                    child: Row(
                      children: [
                        const Text('Đăng nhập'),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Icon(Icons.arrow_forward_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
