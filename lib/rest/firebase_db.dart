import 'package:firebase/firebase.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';

/*
  Singleton class to deal with connection to firebase
 */

class ScrumPokerFirebase {
  Database? _db;
  ScrumSession? scrumSession;
  //callback method to be called when the session is initialized
  dynamic sessionInitializationCallback;
  dynamic sessionInitializationFailedCallback;

  static late final ScrumPokerFirebase instance = ScrumPokerFirebase._();
  ScrumPokerFirebase._() {
    if (apps.isEmpty) {
      initializeApp(
          apiKey: "AIzaSyCnhNtKNvgvP2332dsLp_1SHx7RB0RH9yI",
          authDomain: "scrum-poker-b2819.firebaseapp.com",
          projectId: "scrum-poker-b2819",
          storageBucket: "scrum-poker-b2819.appspot.com",
          messagingSenderId: "708840805223",
          appId: "1:708840805223:web:3566cd157397d6679455c2",
          measurementId: "G-CH265MWWBG",
          databaseURL:
              "https://scrum-poker-b2819-default-rtdb.asia-southeast1.firebasedatabase.app/");
    } else {
      app();
    }
    _db = database();
  }

  Database get realtimeDB => _db!;
  DatabaseReference get dbReference => _db!.ref("sessions");

  void startNewScrumSession(String sessionName, String sessionOwnerName) {
    dbReference.child(sessionName).set({
      "id": ScrumSession.newID(),
      "name": sessionName,
      "startTime": DateTime.now().toUtc().toIso8601String(),
      "participants": [
        ScrumSessionParticipant(
                sessionOwnerName, true, ScrumSessionParticipant.newID())
            .toJson()
      ],
      "summary": {"totalPoints": 0, "totalStories": 0},
      "stories": []
    });
    // getScrumSession(sessionName);
  }

  void onSessionInitialized(dynamic successCallback, dynamic failedCallback) {
    this.sessionInitializationCallback = successCallback;
    this.sessionInitializationFailedCallback = failedCallback;
  }

  void getScrumSession(String sessionId) async {
    dbReference.child(sessionId).once("value").then((event) {
      scrumSession = ScrumSession.fromJson(event.snapshot.toJson());
      this.sessionInitializationCallback(scrumSession);
    });
  }

  void joinScrumSession(
      {required String sessionId,
      required String participantName,
      bool owner: false}) {
    dbReference.child(sessionId).child("participants").push(
        ScrumSessionParticipant(
                participantName, owner, ScrumSessionParticipant.newID())
            .toJson());
    // getScrumSession(sessionId);
  }

  void onNewParticipantAdded(dynamic participantAddedCallback) {
    dbReference
        .child(scrumSession!.name!)
        .child("participants")
        .onChildAdded
        .listen((data) {
      ScrumSessionParticipant participant =
          ScrumSessionParticipant.fromJSON(data.snapshot.toJson());
      //invoke the callback
      participantAddedCallback(participant);
    });
  }

  void onNewParticipantRemoved(dynamic participantRemovedCallback) {
    dbReference
        .child(scrumSession!.name!)
        .child("participants")
        .onChildRemoved
        .listen((data) {
      ScrumSessionParticipant participant =
          ScrumSessionParticipant.fromJSON(data.snapshot.toJson());
      //invoke the callback
      participantRemovedCallback(participant);
    });
  }

  void onNewStorySet(dynamic newStorySetCallback) {
    dbReference
        .child(scrumSession!.name!)
        .child("activeStory")
        .onChildChanged
        .listen((data) {
      Story newStory = Story.fromJSON(data);
      newStorySetCallback(newStory);
    });
  }

  void setActiveStory(id,title,description) {
    Story newStory = Story(id, title, description);
    dbReference
        .child(scrumSession!.name!)
        .child("activeStory")
        .set(newStory.toJson().toString());
  }
}
