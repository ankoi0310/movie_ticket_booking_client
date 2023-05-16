import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_text.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class WebInfo extends StatelessWidget {
  const WebInfo({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UsefulLink(),
          isMobile ? const Spacer(flex: 1) : const SizedBox(width: 50),
          const OtherResources(),
        ],
      ),
    );
  }
}

class UsefulLink extends StatelessWidget {
  const UsefulLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const NormalGreyText(label: 'USEFUL LINKS'),
        CustomTextButton(label: 'About Us', color: Colors.grey[900]!),
        CustomTextButton(label: 'Blog', color: Colors.grey[900]!),
        CustomTextButton(label: 'Github', color: Colors.grey[900]!),
        CustomTextButton(label: 'Free Products', color: Colors.grey[900]!),
      ],
    );
  }
}

class OtherResources extends StatelessWidget {
  const OtherResources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const NormalGreyText(label: 'OTHER RESOURCES'),
        CustomTextButton(label: 'Support Center', color: Colors.grey[900]!),
        CustomTextButton(label: 'Terms of Service', color: Colors.grey[900]!),
        CustomTextButton(label: 'Privacy Policy', color: Colors.grey[900]!),
        CustomTextButton(label: 'Contact Us', color: Colors.grey[900]!),
      ],
    );
  }
}
