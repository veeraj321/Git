import 'dart:math';

import 'package:scrum_poker/theme/theme.dart';
import 'package:uuid/uuid.dart';

///  Represents a Scrum Session

class ScrumSession {
  String? name;
  DateTime? startTime;
  ScrumSessionSummary? summary;
  List<ScrumSessionParticipant> participants = [];
  String? id;

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
            participants.map((participant) => participant.toJson()).toList()
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

  ScrumSessionParticipant(name, isOwner, id) {
    this.name = name;
    this.id = id;
    this.isOwner = isOwner;
  }

  factory ScrumSessionParticipant.fromJSON(dynamic json) {
    return ScrumSessionParticipant(json['name'], json['owner'], json['id']);
  }

  Map<String, dynamic> toJson() =>
      {'name': this.name, 'id': id, 'owner': isOwner};

  static String newID() {
    return DateTime.now().millisecond.toString();
  }
}

// main() {
//   ScrumSession session = ScrumSession(
//       name: "FirstSession", startTime: DateTime.now());
//   session.addParticipant(ScrumSessionParticipant("Jay", true));
//   print(session.toJson());
// }
