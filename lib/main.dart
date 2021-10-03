import 'package:flutter/material.dart';
import 'package:scrum_poker/pages/navigation/navigation_router.dart';
import 'package:scrum_poker/pages/page_not_found/page_not_found.dart';
import 'package:url_strategy/url_strategy.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    print("Error from INSIDE FRAMEWORK");
    print("Error: ${details.exception}");
    print("StackTrace: ${details.stack}");
  };
 // setPathUrlStrategy();
  runApp(ScrumPoker());
}

class ScrumPoker extends StatelessWidget {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
    final AppRouteInformationParser _appRouteInformationParser =
        AppRouteInformationParser();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
      routeInformationParser: _appRouteInformationParser,
      routerDelegate: _appRouterDelegate,
      title: 'Scrum Poker',
    );
  }
}
