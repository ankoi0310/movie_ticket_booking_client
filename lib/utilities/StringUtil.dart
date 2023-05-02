import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';

class StringUtil {
  static String changeMovieFormat(MovieFormat movie) {
    switch (movie) {
      case MovieFormat.twoD:
        return "2D";
      case MovieFormat.threeD:
        return "3D";
      case MovieFormat.fourD:
        return "4DX";
      case MovieFormat.voiceOver:
        return "Lồng tiếng";
      default:
        return "2D";
    }
  }
}