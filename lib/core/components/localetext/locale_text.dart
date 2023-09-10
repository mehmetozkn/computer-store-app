import 'package:auto_size_text/auto_size_text.dart';
import 'package:computer_store_app/core/extension/string_extension.dart';
import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LocaleText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.locale,
      style: style,
    );
  }
}
