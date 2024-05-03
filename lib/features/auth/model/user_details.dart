import 'package:the_quran/features/auth/model/reciter.dart';

class UserDetails {
  String userId;
  String userFullName;
  String userBio;
  List<Reciter> favouriteReciters;

  UserDetails({
    required this.userId,
    required this.userFullName,
    required this.userBio,
    required this.favouriteReciters,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userFullName': userFullName,
      'userBio': userBio,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      userId: map['userId'],
      userFullName: map['userFullName'],
      userBio: map['userBio'],
      favouriteReciters: List.empty(),
    );
  }
}
