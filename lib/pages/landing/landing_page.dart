import 'package:flutter/material.dart';
import 'package:scrum_poker/pages/landing/page_widgets/join_an_existing_session.dart';
import 'package:scrum_poker/pages/landing/page_widgets/start_new_session.dart';
import 'package:scrum_poker/widgets/ui/animatable/animation_constant.dart';
import '../navigation/navigation_router.dart';

class LandingPage extends StatelessWidget {
  final dynamic onTap;
  final AppRouterDelegate? routerDelegate;
  const LandingPage({this.routerDelegate, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: Padding(
          padding: EdgeInsets.only(top:16,left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             AnimatedContainer(duration: Duration(milliseconds: standard_duration),
             width:250,
             child:Image.asset("assets/images/logo_white.png")),
            Expanded(child: Center(
              child: Wrap(
                children: <Widget>[
                  startNewSession(context, routerDelegate!),
                  joinAnExistingSession(context:context, routerDelegate:routerDelegate!)
                ],
                runSpacing: 10.0,
                spacing: 10.0,
              ),
            ))
          ])),
    );
  }
}
