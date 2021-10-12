import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
import 'package:scrum_poker/model/scrum_session_participant_model.dart';
import 'package:scrum_poker/model/story_model.dart';
import 'package:scrum_poker/rest/firebase_db.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';
import 'package:scrum_poker/widgets/ui/extensions/text_extensions.dart';

Widget buildDisplayStoryPanel(
    BuildContext context,
    Story? story,
    dynamic newStoryPressed,
    dynamic showCardsPressed,
    ScrumSessionParticipant? participant,
    ScrumSession? session) {
  return Column(children: [
    Card(
        elevation: 2.0,
        shape: roundedBorder(borderRadius: 5.0),
        child: Container(
          width: 800,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading4(context: context, text: session?.name ?? ''),
                body2(
                    context: context,
                    text: "Click to copy the link to invite your team members"),
                TextButton(
                  child: Wrap(runSpacing: 10, spacing: 10.0, children: [
                    body1(context: context, text: getJoinUrl(session))
                        .color(Colors.blue),
                    Icon(Icons.copy_outlined)
                  ]),
                  onPressed: () {
                    copyUrlToClipboard(context, session);
                  },
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            if (participant?.isOwner ?? false)
              Wrap(runSpacing: 10.0, children: [
                TextButton(
                        onPressed: () {
                          newStoryPressed();
                        },
                        child: buttonText(
                            context: context,
                            text: "NEW STORY",
                            color: Colors.blue))
                    .margin(right: 16.0),
                TextButton(
                        onPressed: () {
                          showCardsPressed();
                        },
                        child: buttonText(
                            context: context,
                            text: "SHOW CARDS",
                            color: Colors.blue))
                    .margin(right: 16.0),
                TextButton(
                    onPressed: () {
                      ScrumPokerFirebase.instance.setActiveStory(
                          story?.id, story?.title, story?.description);
                    },
                    child: buttonText(
                        context: context, text: "REPLAY", color: Colors.blue))
              ])
          ]).paddingAll(24.0),
        )),
    getStoryBoard(context, story) ?? Text('')
  ]);
}

RoundedRectangleBorder roundedBorder({required double borderRadius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius));
}

Widget? getStoryBoard(BuildContext context, Story? story) {
  if ((story?.id?.length ?? 0) > 0 ||
      (story?.title?.length ?? 0) > 0 ||
      (story?.description?.length ?? 0) > 0) {
    return Card(
        elevation: 2.0,
        shape: roundedBorder(borderRadius: 5.0),
        child: Container(
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                body2(context: context, text: story?.id ?? ''),
                heading6(context: context, text: story?.title ?? '')
                    .margin(top: 4.0),
                body1(context: context, text: story?.description ?? '')
                    .margin(top: 4.0),
              ],
            )).paddingAll(16.0));
  }
}

String getJoinUrl(ScrumSession? session) {
  if (session == null) {
    return '';
  } else {
    return "${Uri.base.scheme}://${Uri.base.host}${Uri.base.port != 80 && Uri.base.port != 443 ? ':${Uri.base.port}' : ''}/#/join/${session.id}";
  }
}

void copyUrlToClipboard(BuildContext context, ScrumSession? session) {
  Clipboard.setData(new ClipboardData(text: getJoinUrl(session))).then((_) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Link to your clipboard !')));
  });
}
