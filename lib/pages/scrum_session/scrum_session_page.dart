import 'package:flutter/material.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
import 'package:scrum_poker/model/story_model.dart';
import 'package:scrum_poker/pages/app_shell/header.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/create_story_panel.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/display_story_panel.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/scrum_cards_list.dart';
import 'package:scrum_poker/rest/firebase_db.dart';
import 'package:scrum_poker/pages/scrum_session/page_widgets/participant_card.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';

///✓
class ScrumSessionPage extends StatefulWidget {
  final String id;

  ScrumSessionPage({Key? key, required this.id}) : super(key: key);

  @override
  _ScrumSessionPageState createState() => _ScrumSessionPageState(id);
}

class _ScrumSessionPageState extends State<ScrumSessionPage> {
  String? sessionId;
  ScrumSession? scrumSession;
  Story? activeStory;
  bool showNewStoryInput = false;
  bool showCards = false;
  bool resetParticipantScrumCards = false;

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
    //set callbacks into the session
  }

  void scrumSessionInitializationSuccessful(scrumSession) {
    setState(() {
      this.scrumSession = scrumSession;
      ScrumPokerFirebase.instance.then((ScrumPokerFirebase spfb) {
        spfb.onNewParticipantAdded(onNewParticipantAdded);
        spfb.onNewStorySet(onNewStorySet);
        spfb.onStoryEstimateChanged(onStoryEstimatesChanged);
        spfb.onShowCard(onShowCardsEventTriggered);
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
    return Material(
        child: AnimatedContainer(
            duration: Duration(microseconds: 300),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: buildScrumSessionPage(context)));
  }

  Widget buildScrumSessionPage(BuildContext context) {
    return Column(children: [
      pageHeader(context),
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
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: scrumSession?.participants
                .map((participant) =>
                    participantCard(context, participant, showEstimates))
                .toList() ??
            []);
  }
}
