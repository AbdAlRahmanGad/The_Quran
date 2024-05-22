import 'package:the_quran/features/auth/model/reciter.dart';

class UserDetails {
  String userId;
  String userFullName;
  List<Reciter> favouriteReciters;

  UserDetails({
    required this.userId,
    required this.userFullName,
    required this.favouriteReciters,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userFullName': userFullName,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      userId: map['userId'],
      userFullName: map['userFullName'],
      favouriteReciters: List.empty(),
    );
  }
}
