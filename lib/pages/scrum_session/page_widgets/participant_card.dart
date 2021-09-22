import 'package:flutter/material.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';
import 'package:scrum_poker/widgets/ui/extensions/text_extensions.dart';

Widget participantCard(BuildContext context,
    ScrumSessionParticipant participant, bool showParticipant) {
  return Container(
    height: 200,
    width: 145,
    child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/moroccan-flower.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))),
                      child: Center(
                          child: CircleAvatar(
                        child: heading5(
                                context: context,
                                text: participant.currentEstimate ?? '')
                            .color(Colors.white),
                        radius: ((participant.currentEstimate == null ||
                                participant.currentEstimate == '')
                            ? 0
                            : 40),
                        backgroundColor: Colors.grey[500],
                      )))),
              body1(context: context, text: participant.name)
                  .paddingLRTB(left: 8, right: 8, top: 8, bottom: 16)
            ])),
  ).fadeInOut();
}
