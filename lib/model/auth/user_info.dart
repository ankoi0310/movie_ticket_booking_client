import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/general.dart';

class UserInfo extends General {
  String firstName;
  String lastName;
  String fullName;
  bool isMale;
  String avatar;
  DateTime dateOfBirth;

  UserInfo({
    required int id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.isMale,
    required this.avatar,
    required this.dateOfBirth,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
          id: id,
          state: state,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          deletedDate: deletedDate);

  UserInfo.empty()
      : firstName = '',
        lastName = '',
        fullName = '',
        isMale = false,
        avatar = '',
        dateOfBirth = DateTime.now(),
        super.empty();

  @override
  bool operator ==(other) {
    return (other is UserInfo) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      isMale: json['isMale'],
      avatar: json['avatar'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      state: GeneralState.values.firstWhere((e) => e.value == json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate:
      DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'isMale': isMale,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
