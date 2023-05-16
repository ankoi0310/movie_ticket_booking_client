import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  final String avatar;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: accentColor,
        backgroundImage: NetworkImage(widget.avatar),
      ),
    );
  }
}
