import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/avatar.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  final UserInfo userInfo;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  late UserInfoRequest userInfoRequest;
  late CustomFlutterToast toast;
  late bool _isMale = true;

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    toast = CustomFlutterToast();
    toast.init(AppRouterDelegate.instance.navigatorKey.currentContext!);
  }

  Future<void> updateProfile() async {
    setState(() {
      isUpdating = true;
    });

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      userInfoRequest.isMale = _isMale;

      HttpResponse response = await userProvider.updateProfile(userInfoRequest);

      setState(() {
        isUpdating = false;
      });

      if (response.success) {
        toast.showToast(
          success: true,
          message: 'Cập nhật thông tin thành công',
        );
      } else {
        toast.showToast(
          success: false,
          message: response.message,
        );
      }
    } else {
      setState(() {
        isUpdating = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    userInfoRequest = UserInfoRequest.fromCurrent(widget.userInfo);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(20),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Họ và tên: ',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: getProportionateScreenWidth(200),
                                child: TextFormField(
                                  initialValue: widget.userInfo.fullName,
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      userInfoRequest.fullName = value ?? '';
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Giới tính: ',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: RadioListTile<bool>(
                                      title: const Text('Nam'),
                                      value: true,
                                      groupValue: _isMale,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isMale = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: getProportionateScreenWidth(20)),
                                  Flexible(
                                    child: RadioListTile<bool>(
                                      title: const Text('Nữ'),
                                      value: false,
                                      groupValue: _isMale,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isMale = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Ngày sinh: ',
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                initialValue: widget.userInfo.dateOfBirth,
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );

                                  if (date != null) {
                                    setState(() {
                                      userInfoRequest.dateOfBirth = DateFormat('dd/MM/yyyy').format(date);
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    userInfoRequest.dateOfBirth = value ?? '';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        ElevatedButton(
                          onPressed: () async {
                            await updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenHeight(10),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Lưu'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Avatar(avatar: widget.userInfo.avatar),
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
                'Thông tin cá nhân',
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
    );
  }
}
