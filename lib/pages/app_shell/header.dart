import 'package:flutter/material.dart';
import 'package:scrum_poker/widgets/ui/responsive_widget.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';

Widget pageHeader(BuildContext context) {
  return AppBar(
    centerTitle: false,
    title: Column(children: [
      heading5(context: context, text: "Agile Square", color: Colors.white),
      heading6(context: context, text: "Planning Poker", color: Colors.white70)
    ]),
    elevation: 0.0,
    bottomOpacity: 0.0,
  );
}
