import 'package:flutter/material.dart';
import 'package:scrum_poker/widgets/ui/typograpy_widgets.dart';
import 'package:scrum_poker/widgets/ui/extensions/widget_extensions.dart';

Widget buildDisplayStoryPanel(BuildContext context) {
  return Card(
    elevation: 2.0,
    shape: roundedBorder(borderRadius: 5.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.grey[100]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              body1(context: context, text: "STORY    S1-01-01"),
              heading5(
                      context: context,
                      text:
                          "As a supplier I should be able to check for any incoming orders")
                  .margin(top: 4.0),
              subtitle1(
                      context: context,
                      text:
                          "Supplier has to be constantly looking for any orders that are coming in from the vendors")
                  .margin(top: 16.0, bottom: 16.0),
            ],
          ).paddingAll(32)),
      Wrap(runSpacing: 10.0, children: [
        TextButton(
                onPressed: () {},
                child: buttonText(
                    context: context, text: "NEW STORY", color: Colors.blue))
            .margin(right: 16.0),
        TextButton(
            onPressed: () {},
            child: buttonText(
                context: context, text: "SHOW CARDS", color: Colors.blue))
      ]).margin(top: 24)
    ]).paddingAll(24.0),
  );
}

RoundedRectangleBorder roundedBorder({required double borderRadius}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius));
}
