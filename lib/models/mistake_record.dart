class MistakeRecord {
  final String errorType;
  int count;

  MistakeRecord({
    required this.errorType,
    this.count = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'errorType': errorType,
      'count': count,
    };
  }

  factory MistakeRecord.fromJson(Map<String, dynamic> json) {
    return MistakeRecord(
      errorType: json['errorType'] as String,
      count: json['count'] as int? ?? 0,
    );
  }
}
