import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class LargeBoldTextBlack extends StatelessWidget {
  const LargeBoldTextBlack({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 25,
        color: Colors.grey[700],
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
    );
  }
}

class NormalGreyText extends StatelessWidget {
  const NormalGreyText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        wordSpacing: 1,
        letterSpacing: .5,
        color: Colors.grey[500],
      ),
    );
  }
}

class BoldBlackText extends StatelessWidget {
  const BoldBlackText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),
    );
  }
}

class SmallBlackText extends StatelessWidget {
  const SmallBlackText({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),
    );
  }
}
