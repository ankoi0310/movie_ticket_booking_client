import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/change_password_form.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/profile_form.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/reset_password_field.dart';

class ProfileInfoTab extends StatefulWidget {
  const ProfileInfoTab({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  final UserInfo userInfo;

  @override
  State<ProfileInfoTab> createState() => _ProfileInfoTabState();
}

class _ProfileInfoTabState extends State<ProfileInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(10),
            ),
            child: ProfileForm(userInfo: widget.userInfo),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20),
          ),
          child: const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 10,
          ),
        ),
        const Expanded(
          child: Row(
            children: [
              Expanded(
                child: ChangePasswordForm(),
              ),
              Expanded(
                child: ResetPasswordField(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
