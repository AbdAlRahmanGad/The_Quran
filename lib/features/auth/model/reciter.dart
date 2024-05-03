class Reciter {
  int reciterId;
  String reciterName;
  String reciterStyle;

  Reciter({
    required this.reciterId,
    required this.reciterName,
    required this.reciterStyle,
  });

  Map<String, dynamic> toMap() {
    return {
      'reciterId': reciterId,
      'reciterName': reciterName,
      'reciterStyle': reciterStyle,
    };
  }

  factory Reciter.fromMap(Map<String, dynamic> map) {
    return Reciter(
      reciterId: map['reciterId'],
      reciterName: map['reciterName'],
      reciterStyle: map['reciterStyle'],
    );
  }
}
