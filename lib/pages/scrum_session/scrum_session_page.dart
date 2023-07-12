import 'package:flutter/material.dart';
//import 'package:scrum_poker/ExitSession/exit.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
//import 'package:scrum_poker/model/scrum_session_participant_model.dart';
import 'package:scrum_poker/model/story_model.dart';
import 'package:scrum_poker/pages/app_shell/header.dart';
import 'package:scrum_poker/pages/navigation/navigation_router.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/create_story_panel.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/display_story_panel.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/scrum_cards_list.dart';
import 'package:scrum_poker/rest/firebase_db.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/participant_card.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';
//import 'dart:html';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

//html.Element? appElement; // Reference to your app element

void main() {}

bool isHostExiting(html.Event event) {
  // Customize this logic based on your app's requirements
  // For example, you can check for specific conditions or permissions
  // to determine if the host is leaving the page directly
  return true; // Replace with your own condition
}

void showToastMessage() {
  // Replace with your own toast implementation or package

  Fluttertoast.showToast(
    msg: "Host has exited",
    toastLength:
        Toast.LENGTH_SHORT, // Duration for which the toast should be visible
    gravity: ToastGravity.CENTER, // Position of the toast message on the screen
    timeInSecForIosWeb:
        30, // Specific to iOS/web platforms, the duration for which the toast should be visible
    backgroundColor: Colors.black87, // Background color of the toast message
    textColor: Colors.white, // Text color of the toast message
    fontSize: 16.0, // Font size of the toast message
  );
  //print("Host has exited");
}

///✓
class ScrumSessionPage extends StatefulWidget {
  final String id;
  final AppRouterDelegate? routerDelegate;

  ScrumSessionPage({Key? key, required this.id, this.routerDelegate})
      : super(key: key);

  @override
  _ScrumSessionPageState createState() => _ScrumSessionPageState(id);
}

class _ScrumSessionPageState extends State<ScrumSessionPage> {
  String? sessionId;
  ScrumSession? scrumSession;
  Story? activeStory;
  AppRouterDelegate? routerDelegater;
  bool showNewStoryInput = false;
  bool showCards = false;
  bool resetParticipantScrumCards = false;
  bool exitPage = false;

  _ScrumSessionPageState(String id) {
    this.sessionId = id;
  }

  void initializeScrumSession() async {
    ScrumPokerFirebase spfb = await ScrumPokerFirebase.instance;
    spfb.onSessionInitialized(
        scrumSessionInitializationSuccessful, scrumSessionInitializationFailed);
    spfb.getScrumSession(widget.id);
  }

  @override
  void initState() {
    super.initState();
    initializeScrumSession();
    //onSessionExit();
    //appElement =
    // html.querySelector('#app'); // Replace 'app' with your app element ID

    //set callbacks into the session
  }

  // void onSessionExit() {
  //   // window.onBeforeUnload.listen((event) {
  //   //   // Code to execute when the browser is closed or navigated away
  //   //   //delete the scrum session with the current id in firebase
  //   //   //display msg to user that the session expired
  //   //   //go back to previous page
  //   //   //ExitSession(deleteSessionFromFirebase);
  //   //   //setState(() {
  //   //   //print(scrumSession!.participants);
  //   //   // exitPage = true;

  //   //   //scrumSession!.participants.clear();
  //   //   //print('set state exe');
  //   //   //print(scrumSession!.participants);
  //   //   //});

  //   //   print('Browser is closing or navigating away!');
  //   // });
  //   html.window.onBeforeUnload.listen((html.Event event) {
  //     // Check if the host is leaving the page

  //     if (isHostExiting(event)) {
  //       setState(() {
  //         print('set state');
  //         exitPage = true;
  //         //showToastMessage();
  //       });
  //     }
  //   });
  // }

  void scrumSessionInitializationSuccessful(scrumSession) {
    setState(() {
      this.scrumSession = scrumSession;
      ScrumPokerFirebase.instance.then((ScrumPokerFirebase spfb) {
        spfb.onNewParticipantAdded(onNewParticipantAdded);
        spfb.onNewStorySet(onNewStorySet);
        spfb.onStoryEstimateChanged(onStoryEstimatesChanged);
        spfb.onShowCard(onShowCardsEventTriggered);
        spfb.onEndSession(sessionExit);
        spfb.onNewParticipantRemoved(onNewParticipantRemoved);
      });
    });
  }

  void scrumSessionInitializationFailed(error) {
    // ignore: todo
    //todo: implement erro handling
  }

  void onNewParticipantAdded(newParticipant) {
    setState(() {
      this.scrumSession?.addParticipant(newParticipant);
    });
  }

  void onNewParticipantRemoved(oldParticipant) {
    setState(() {
      this.scrumSession?.removeParticipant(oldParticipant);
    });
    print(oldParticipant);
    // ScrumSessionParticipant sp = oldParticipant;
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     duration: const Duration(seconds: 3),
    //     content: Text("${oldParticipant.name}"),
    //   ),
    // );
  }

  void sessionExit() {
    widget.routerDelegate!.pushRoute("/session-ended");
  }

  void onNewStorySet(story) {
    setState(() {
      this.activeStory = story;
      this.showCards = false;
      this.showNewStoryInput = false;
      this.scrumSession?.participants.forEach((participant) {
        participant.currentEstimate = '';
      });
      this.resetParticipantScrumCards = true;
    });
  }

  void onNewStoryPressed() {
    //  ScrumPokerFirebase.instance.setActiveStory(null, null, null);
    setState(() {
      this.showNewStoryInput = true;
    });
  }

  void onShowCardsButtonPressed() {
    ScrumPokerFirebase.instance
        .then((ScrumPokerFirebase spfb) => spfb.showCard());
  }

  void onShowCardsEventTriggered(bool value) {
    setState(() {
      this.showCards = value;
    });
  }

  void onCardSelected(String selectedValue) {
    this.resetParticipantScrumCards = false;
    ScrumPokerFirebase.instance.then(
        (ScrumPokerFirebase spfb) => spfb.setStoryEstimate(selectedValue));
  }

  onStoryEstimatesChanged(participantEstimates) {
    if (participantEstimates != null && participantEstimates is Map) {
      var estimateJson = participantEstimates.values;
      var participants = scrumSession?.participants ?? [];
      for (var estimate in estimateJson) {
        var index = 0;
        for (var participant in participants) {
          if (estimate["participantid"] == participant.id) {
            scrumSession?.participants[index].currentEstimate =
                estimate["estimate"];
            break;
          }
          index = index + 1;
        }
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //onSessionExit();
    return Material(
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: buildScrumSessionPage(context),
      ),
    );
  }

  Widget buildScrumSessionPage(BuildContext context) {
    return Column(children: [
      pageHeader(context, scrumSession, scrumSession?.activeParticipant),
      ((this.showNewStoryInput == false)
          ? buildDisplayStoryPanel(
              context,
              activeStory,
              onNewStoryPressed,
              onShowCardsButtonPressed,
              scrumSession?.activeParticipant,
              scrumSession)
          : buildCreateStoryPanel(context)),
      Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
        buildParticipantsPanel(context, showCards),
        Divider(
          color: Colors.white38,
        ).margin(top: 8.0, bottom: 8.0),
        ScrumCardList(
            onCardSelected: onCardSelected,
            resetCardList: this.resetParticipantScrumCards,
            isLocked: this.showCards)
      ])))
    ]);
  }

  Widget buildParticipantsPanel(BuildContext context, showEstimates) {
    //print(" --In build of ParticipantPanel ${scrumSession!.participants}");
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: scrumSession?.participants
                .map((participant) =>
                    participantCard(context, participant, showEstimates))
                .toList() ??
            []);
  }
}
