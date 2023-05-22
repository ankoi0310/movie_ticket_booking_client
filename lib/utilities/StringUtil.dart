import 'package:movie_ticket_booking_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/combo_item.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/notice.dart';

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
  static String changeNoticeType(NoticeType type) {
    switch (type) {
      case NoticeType.booked:
        return "Đã đặt vé";
      case NoticeType.remind:
        return "Nhắc nhở";
      default:
        return "2D";
    }
  }

 static changeToDescriptionCombo(Combo combo) {
    String description = "";
    for (ComboItem comboItem in combo.comboItems) {
      description += "${comboItem.product!.name} x ${comboItem.quantity}, ";
    }
    description = description.substring(0, description.length - 2);
    return description;
  }
}