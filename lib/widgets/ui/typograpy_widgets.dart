import 'dart:js';

import 'package:flutter/material.dart';

/**
 * Contains all the functions to get the UI components 
 */

Text heading6({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline6);
}

Text heading5({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline5);
}

Text heading4({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline4);
}

Text heading3({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline3);
}

Text heading2({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline2);
}

Text heading1({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.headline1);
}

Text subtitle1({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.subtitle1);
}

Text subtitle2({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.subtitle2);
}

Text body2({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.bodyText2);
}

Text body1({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.bodyText1);
}

Text caption({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.caption);
}

Text overline({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.overline);
}

Text buttonText({required context, required String text}) {
  return _getStyledText(text, Theme.of(context).textTheme.button);
}

Text _getStyledText(text, textStyle) {
  return Text(
    text,
    style: textStyle,
  );
}
