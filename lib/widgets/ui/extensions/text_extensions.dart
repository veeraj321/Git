import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text color(Color color) {
    Text t = Text(
      this.data ?? "",
      style: this.style?.copyWith(color: color) ?? TextStyle(color: color),
    );
    return t;
  }
}
