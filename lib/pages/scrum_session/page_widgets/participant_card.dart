import 'package:flutter/material.dart';
import 'package:scrum_poker/model/scrum_session_model.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';
import 'package:scrum_poker/widgets/ui/extensions/text_extensions.dart';

Widget participantCard(BuildContext context,
    ScrumSessionParticipant participant, bool showParticipant) {
  return Container(
    height: 275,
    width: 200,
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
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))

                              ),
                      child: Center(
                          child: CircleAvatar(
                        child: heading2(context: context, text: "13")
                            .color(Colors.white),
                        radius: 65,
                      )))),
              heading6(context: context, text: participant.name)
                  .paddingLRTB(left: 16, right: 16, top: 16, bottom: 24)
            ])),
  ).fadeInOut();
}
