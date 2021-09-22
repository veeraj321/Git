import 'package:flutter/material.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
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
  bool _showCards = false;
  Story? activeStory;
  bool showNewStoryInput = false;
  _ScrumSessionPageState(String id) {
    this.sessionId = id;
    ScrumPokerFirebase.instance.onSessionInitialized(
        scrumSessionInitializationSuccessful, scrumSessionInitializationFailed);
  }

  @override
  void initState() {
    super.initState();
    ScrumPokerFirebase.instance.getScrumSession(sessionId!);
    //set callbacks into the session
  }

  void scrumSessionInitializationSuccessful(scrumSession) {
    setState(() {
      this.scrumSession = scrumSession;
      this._showCards = true;
      ScrumPokerFirebase.instance.onNewParticipantAdded(onNewParticipantAdded);
      ScrumPokerFirebase.instance.onNewStorySet(onNewStorySet);
      ScrumPokerFirebase.instance
          .onStoryEstimateChanged(onStoryEstimatesChanged);
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
    });
  }

  void onNewStoryPressed() {
    setState(() {
      this.showNewStoryInput = true;
    });
  }

  void onShowCardsPressed() {}

  void onCardSelected(String selectedValue) {
    ScrumPokerFirebase.instance.setStoryEstimate(selectedValue);
  }

  onStoryEstimatesChanged(participantEstimates) {
   // print("Story estimates changed $participantEstimates");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(microseconds: 300),
        color: Theme.of(context).colorScheme.primary,
        child: buildScrumSessionPage(context));
  }

  Widget buildScrumSessionPage(BuildContext context) {
    return Column(children: [
      pageHeader(context),
      ((this.showNewStoryInput == false)
          ? buildDisplayStoryPanel(
              context, activeStory, onNewStoryPressed, onShowCardsPressed)
          : buildCreateStoryPanel(context)),
      Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
        buildParticipantsPanel(context),
        Divider(
          color: Colors.white38,
        ).margin(top: 8.0, bottom: 8.0),
        ScrumCardList(onCardSelected: onCardSelected)
      ])))
    ]);
  }

  Widget buildParticipantsPanel(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: scrumSession?.participants
                .map((participant) =>
                    participantCard(context, participant, _showCards))
                .toList() ??
            []);
  }
}
