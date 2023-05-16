import 'package:movie_ticket_booking_flutter_nlu/component/custom_button.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/custom_text.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  final String data =
      'An artist of considerable range, Jenna the name taken by Melbourne-raised, Brooklyn-based Nick Murphy writes, performs and records all of his own music, giving it a warm, intimate feel with a solid groove structure. An artist of considerable range.';

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context) ? true : false;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      /// card header
      SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            buildSocialValue('Friends', 22),
            buildSocialValue('Photos', 10),
            buildSocialValue('Comments', 86),
            const Spacer(flex: 10),
            NormalButton(
              label: 'Edit',
              textColor: Colors.white,
              backgroundColor: Colors.teal[300]!,
              onTap: () {},
            ),
            const Spacer(flex: 1)
          ],
        ),
      ),
      SizedBox(height: isMobile ? 20 : 50),
      const LargeBoldTextBlack(label: 'Jenna Stones'),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_pin, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 5),
          const NormalGreyText(label: 'LOS ANGELES, CALIFORNIA'),
        ],
      ),
      const SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(Icons.work, size: 20, color: Colors.grey[400]),
        const SizedBox(width: 5),
        const NormalGreyText(label: 'Solution Manager - Creative Team Officer')
      ]),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 5),
          const NormalGreyText(label: 'University of Computer Science'),
        ],
      ),

      /// description
      Divider(height: 30, thickness: 1, color: Colors.grey[300]),
      NormalGreyText(label: data),
      const SizedBox(height: 10),
      const CustomTextButton(
        label: 'Show more',
        color: Colors.green,
      )
    ]);
  }

  Widget buildSocialValue(String label, int value) => Container(
        padding: const EdgeInsets.all(5),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
}
