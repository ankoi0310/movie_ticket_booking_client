import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  late final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  late CustomFlutterToast toast;

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    toast = CustomFlutterToast();
    toast.init(context);
  }

  Future<void> changePassword() async {
    setState(() {
      isUpdating = true;
    });

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      String password = passwordController.text;
      String newPassword = newPasswordController.text;
      HttpResponse response = await userProvider.changePassword(password, newPassword);

      setState(() {
        isUpdating = false;
      });

      toast.showToast(
        success: response.success,
        message: response.message,
      );
    } else {
      setState(() {
        isUpdating = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(15),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(15),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Mật khẩu cũ',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                gapPadding: 0,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Vui lòng nhập mật khẩu cũ';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          TextFormField(
                            obscureText: true,
                            controller: newPasswordController,
                            decoration: const InputDecoration(
                              hintText: 'Mật khẩu mới',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Vui lòng nhập mật khẩu mới';
                              }

                              if (value == passwordController.text) {
                                return 'Mật khẩu mới không được trùng với mật khẩu cũ';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Nhập lại mật khẩu mới',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Vui lòng nhập lại mật khẩu mới';
                              }

                              if (value != newPasswordController.text) {
                                return 'Mật khẩu nhập lại không khớp';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          TextButton(
                            onPressed: () async => await changePassword(),
                            style: TextButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20),
                                vertical: getProportionateScreenHeight(10),
                              ),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            ),
                            child: const Text(
                              'Lưu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: getProportionateScreenHeight(-25),
            left: getProportionateScreenWidth(10),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: const Text(
                  'Đổi mật khẩu',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
