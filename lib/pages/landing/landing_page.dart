import 'package:flutter/material.dart';
import 'package:scrum_poker/pages/landing/page_widgets/join_an_existing_session.dart';
import 'package:scrum_poker/pages/landing/page_widgets/start_new_session.dart';
import '../navigation/navigation_router.dart';

class LandingPage extends StatelessWidget {
  final dynamic onTap;
  final AppRouterDelegate? routerDelegate;
  const LandingPage({this.routerDelegate, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Center(
            child: Wrap(
              children: <Widget>[
                startNewSession(context, routerDelegate!),
                joinAnExistingSession(context, routerDelegate!)
              ],
              runSpacing: 10.0,
              spacing: 10.0,
            ),
          )),
    );
  }
}
