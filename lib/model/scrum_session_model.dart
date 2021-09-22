///  Represents a Scrum Session

class ScrumSession {
  String? name;
  DateTime? startTime;
  ScrumSessionSummary? summary;
  List<ScrumSessionParticipant> participants = [];
  String? id;
  ScrumSessionParticipant? activeParticipant;
  String? activeParticipantKey;
  Story? activeStory;

  ScrumSession({required startTime, required name}) {
    this.id = newID();
    this.name = name;
    this.startTime = startTime;
  }

  ScrumSession.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    startTime = DateTime.parse(json['startTime']);
    summary = ScrumSessionSummary.fromJson(json['summary']);
    Map _participantsListJson = json['participants'];

    participants = _participantsListJson.values
        .map((participantJson) =>
            ScrumSessionParticipant.fromJSON(participantJson))
        .toList();
  }

  void addParticipant(ScrumSessionParticipant participant) {
    bool found = false;
    for (var aParticipant in this.participants) {
      if (aParticipant.id == participant.id) {
        found = true;
        break;
      }
    }
    if (!found) {
      this.participants.add(participant);
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startTime': (startTime?.toIso8601String() ?? ''),
        'summary': summary?.toJson(),
        'participants':
            participants.map((participant) => participant.toJson()).toList(),
        'activeParticant': this.activeParticipant?.toJson(),
        'activeParticipantKey': this.activeParticipantKey
      };

  static String newID() {
    return DateTime.now().millisecond.toString();
  }
}

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

class ScrumSessionParticipant {
  String id = newID();
  String name = "";
  bool isOwner = false;
  String? currentEstimate;
  ScrumSessionParticipant(name, isOwner, id, currentEstimate) {
    this.name = name;
    this.id = id;
    this.isOwner = isOwner;
    this.currentEstimate = currentEstimate;
  }

  factory ScrumSessionParticipant.fromJSON(dynamic json) {
    return ScrumSessionParticipant(
        json['name'], json['owner'], json['id'], json['currentEstimate']);
  }

  Map<String, dynamic> toJson() =>
      {'name': this.name, 'id': id, 'owner': isOwner};

  static String newID() {
    return DateTime.now().millisecond.toString();
  }
}

class Story {
  String? id;
  String? title;
  String? description;
  List estimates = [];
  Story(this.id, this.title, this.description, this.estimates);
  // {
  //   this.id = id;
  //   this.title = title;
  //   this.description = description;
  // }

  factory Story.fromJSON(dynamic json) {
    var estimates = json["participantEstimates"]?.values ?? [];
    var estimateList = estimates
        ?.map((element) => StoryParticipantEstimate.fromJSON(element))
        .toList();
   
    return Story(json["id"], json["title"], json["description"], estimateList);
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'id': id,
        'description': this.description,
        'participantEstimates':
            estimates.map((estimate) => estimate.toJson()).toList()
      };
}

class StoryParticipantEstimate {
  String? participantId;
  String? participantKey;
  String? estimate;
  StoryParticipantEstimate(
      {this.participantId, this.estimate, this.participantKey});

  factory StoryParticipantEstimate.fromJSON(dynamic json) {
    return StoryParticipantEstimate(
        participantId: json["participantId"],
        estimate: json["estimate"],
        participantKey: json["participantKey"]);
  }
  Map<String, String> toJson() => {
        'participantid': this.participantId ?? '',
        'estimate': this.estimate ?? '',
        'participantKey': this.participantKey ?? ''
      };
}

// main() {
//   ScrumSession session = ScrumSession(
//       name: "FirstSession", startTime: DateTime.now());
//   session.addParticipant(ScrumSessionParticipant("Jay", true));
//   print(session.toJson());
// }
