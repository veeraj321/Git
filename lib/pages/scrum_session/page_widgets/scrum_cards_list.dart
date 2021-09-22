import 'package:flutter/material.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';
import 'package:scrum_poker/widgets/ui/extensions/text_extensions.dart';

import 'scrum_card.dart';

class ScrumCardList extends StatefulWidget {
  final dynamic onCardSelected;
  ScrumCardList({Key? key, this.onCardSelected}) : super(key: key);

  _ScrumCardListState createState() => _ScrumCardListState();
}

class _ScrumCardListState extends State<ScrumCardList> {
  String? selectedCardValue;
  List cardValues = [
    "0.5",
    "1",
    "2",
    "3",
    "5",
    "8",
    "13",
    "21",
    "40",
    "?",
    "∞"
  ];

  void cardSelected(String selectedCardValue) {
    setState(() {
      if (this.selectedCardValue == selectedCardValue) {
        this.selectedCardValue = '';
      } else {
        this.selectedCardValue = selectedCardValue;
      }
      widget.onCardSelected(this.selectedCardValue);
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
         // heading6(context: context, text: "My Estimate").color(Colors.white).margin(bottom:8.0),
      Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: cardValues
              .map((cardValue) => ScrumCard(
                    onCardSelected: cardSelected,
                    value: cardValue,
                    isSelected: (cardValue == selectedCardValue),
                  ))
              .toList()),
      
    ]));
  }
}
