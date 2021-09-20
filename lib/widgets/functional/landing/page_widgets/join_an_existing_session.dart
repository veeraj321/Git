import 'package:flutter/material.dart';
import 'package:scrum_poker/rest/firebase_db.dart';
import 'package:scrum_poker/theme/theme.dart';
import 'package:scrum_poker/widgets/functional/navigation/navigation_router.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';

Widget joinAnExistingSession(
    BuildContext context, AppRouterDelegate routerDelegate) {
  TextEditingController existingSessionController = TextEditingController();
  TextEditingController participantNameController = TextEditingController();
  return Container(
    child: Card(
        child: Padding(
            padding: EdgeInsets.all(dimensions.standard_padding * 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heading5(context: context, text: "Join an Existing Session"),
              SizedBox(
                height: 10,
              ),
              body1(
                  context: context,
                  text: "Please enter the name of the session and press join"),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: existingSessionController,
                decoration:
                    InputDecoration(hintText: "Enter the name of the session"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: participantNameController,
                decoration:
                    InputDecoration(hintText: "Enter your name or nickname"),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        // print(RouteDirectory.homePage(sessionId: 2));
                        // Navigator.pushNamed(context,
                        //     RouteDirectory.homePage(sessionId: 20));
                        // print("pressed");
                        // print(this.onTap);
                        // this.onTap("1");
                        // var existingSession = ScrumPokerFirebase.instance
                        //     .getScrumSessionById(
                        //         existingSessionController.text);
                        /*
                         existingSessionController.text,
                            participantNameController.text);*/
                        ScrumPokerFirebase.instance.joinScrumSession(
                            participantName: participantNameController.text,
                            sessionId: existingSessionController.text, owner: false);

                        routerDelegate.pushRoute(
                            "/home/${existingSessionController.text}");
                      },
                      child: Text("JOIN")))
            ]))),
    width: 500,
  );
}
