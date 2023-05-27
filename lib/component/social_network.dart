import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_text.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class SocialNetwork extends StatelessWidget {
  const SocialNetwork({
    Key? key,
    required this.isDesktop,
  }) : super(key: key);

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BoldBlackText(label: 'Let\'s keep in touch!'),
          const NormalGreyText(label: 'Find us on any of these platforms, we respond 1-2 business days.'),
          const SizedBox(height: 10),
          Row(
            children: [
              if (!isDesktop) const Spacer(flex: 1),
              FloatingIconButton(
                path: 'icons/facebook.svg',
                onPressed: () {},
              ),
              FloatingIconButton(
                path: 'icons/linkedin.svg',
                onPressed: () {},
              ),
              FloatingIconButton(
                path: 'icons/skype.svg',
                onPressed: () {},
              ),
              FloatingIconButton(
                path: 'icons/twitter.svg',
                onPressed: () {},
              ),
              FloatingIconButton(
                path: 'icons/youtube.svg',
                onPressed: () {},
              ),
              if (!isDesktop) const Spacer(flex: 1)
            ],
          )
        ],
      ),
    );
  }
}

class FloatingIconButton extends StatelessWidget {
  const FloatingIconButton({
    Key? key,
    required this.path,
    required this.onPressed,
  }) : super(key: key);

  final String path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 40,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: onPressed,
        child: ColorCustomIconButton(path: path),
      ),
    );
  }
}
