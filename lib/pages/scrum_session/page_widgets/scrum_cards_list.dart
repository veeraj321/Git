import 'package:flutter/material.dart';

import 'scrum_card.dart';

class ScrumCardList extends StatefulWidget {
  final dynamic onCardSelected;
  final bool resetCardList;
  final bool isLocked;
  ScrumCardList({Key? key, this.onCardSelected, required this.resetCardList,required this.isLocked})
      : super(key: key);

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
    if(!widget.isLocked){
      setState(() {
        if (this.selectedCardValue == selectedCardValue) {
          this.selectedCardValue = '';
        } else {
          this.selectedCardValue = selectedCardValue;
        }
        widget.onCardSelected(this.selectedCardValue);
      });
    }
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
                    isSelected: (cardValue == selectedCardValue &&
                        !widget.resetCardList),
                  ))
              .toList()),
    ]));
  }
}
