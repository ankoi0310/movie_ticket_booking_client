import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  final String avatar;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final AuthenticationService _authenticationService = AuthenticationService.instance;

  late final UserProvider _userProvider = Provider.of<UserProvider>(context, listen: false);
  late final CustomFlutterToast _toast = CustomFlutterToast();

  @override
  void initState() {
    super.initState();
    _toast.init(context);
  }

  Future<void> _selectImageWeb() async {
    final FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      lockParentWindow: true,
    );

    if (result != null) {
      HttpResponse response = await _userProvider.uploadAvatar(result.files.single.bytes!);

      if (response.success) {
        _authenticationService.saveCurrentAvatar(response.data!);
      }

      _toast.showToast(
        success: response.success,
        message: response.message,
      );
    }
  }

  Future<void> _selectImageMobile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      HttpResponse response = await _userProvider.uploadAvatar(result.files.single.bytes!);

      _toast.showToast(
        success: response.success,
        message: response.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.1,
          height: SizeConfig.screenWidth * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(widget.avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        ElevatedButton(
          onPressed: kIsWeb ? _selectImageWeb : _selectImageMobile,
          child: const Text('Chỉnh sửa'),
        ),
      ],
    );
  }
}
