class ScrumSessionSummary {
  double totalPoints = 0.0;
  double totalStories = 0.0;

  ScrumSessionSummary(totalPoints, totalStories);

  factory ScrumSessionSummary.fromJson(dynamic json) {
    return ScrumSessionSummary(
        json['totalPoints'] as double, json['totalStories'] as double);
  }

  Map<String, dynamic> toJson() =>
      {'totalPoints': totalPoints, 'totalStories': totalStories};
}