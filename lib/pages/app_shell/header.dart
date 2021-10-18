import 'package:flutter/material.dart';
import 'package:scrum_poker/theme/theme.dart';
import 'package:scrum_poker/widgets/ui/animatable/animation_constant.dart';
import 'package:scrum_poker/widgets/ui/responsive_widget.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';

Widget pageHeader(BuildContext context) {
  return AppBar(
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // AnimatedContainer(duration: Duration(milliseconds: standard_duration),
      //        width:150,
      //        child:Image.asset("assets/images/logo_white.png")),
      heading6(context: context, text: "Scrum Poker", color: Colors.white)
    ]),
    elevation: 0.0,
    bottomOpacity: 0.0,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
