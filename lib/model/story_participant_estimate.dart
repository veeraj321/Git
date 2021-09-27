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
