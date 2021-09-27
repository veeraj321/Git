import 'package:scrum_poker/model/story_participant_estimate.dart';

class Story {
  String? id;
  String? title;
  String? description;
  List estimates = [];
  bool showCards = false;
  Story(this.id, this.title, this.description, this.estimates);
  // {
  //   this.id = id;
  //   this.title = title;
  //   this.description = description;
  // }

  factory Story.fromJSON(dynamic json) {
    String? anId, aDescription, aTitle;
    var estimateList = [];
    if (json != null) {
      var estimates = json["participantEstimates"] ?? [];

      if (estimates is Map) {
        estimateList = estimates.values
            .map((element) => StoryParticipantEstimate.fromJSON(element))
            .toList();
      }
      anId = json["id"];
      aDescription = json["description"];
      aTitle = json["title"];
    }
    return Story(anId, aTitle, aDescription, estimateList);
  }

  Map<String, dynamic> toJson() {
    var json = {
      'title': this.title,
      'id': id,
      'description': this.description,
      'participantEstimates':
          estimates.map((estimate) => estimate.toJson()).toList(),
      'showCards': showCards,
      'created':DateTime.now().toIso8601String()
    };
    return json;
  }
}
