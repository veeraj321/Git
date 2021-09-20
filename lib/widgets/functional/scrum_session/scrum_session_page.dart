import 'package:flutter/material.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
import 'package:scrum_poker/rest/firebase_db.dart';
import 'package:scrum_poker/widgets/functional/scrum_session/page_widgets/participant_card.dart';
import 'package:scrum_poker/widgets/ui/animatable/fade_in_out.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.primary,
        child:Column(children: [ 
          Expanded(child:buildScrumSessionPage(context),
        )]),);
  }

  Widget buildScrumSessionPage(BuildContext context) {
    return   SingleChildScrollView(child:Wrap(
            children: scrumSession?.participants
                    .map((participant) =>
                        participantCard(context, participant, _showCards))
                    .toList() ??
                []));
  }
}
