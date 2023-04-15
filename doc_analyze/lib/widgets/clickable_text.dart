import 'package:doc_analyze/extension/text_style_extension.dart';
import 'package:doc_analyze/theme/text_style.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? style;
  final Color? linkColor;
  final bool underline;

  const ClickableText(this.text,
      {Key? key,
      this.onPressed,
      this.style,
      this.underline = false,
      this.linkColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = (style ?? TextStyles.body1.textColor(Colors.white) );
    Widget txt = Text(
      text,
      style: style ??
          (underline ? ts.copyWith(decoration: TextDecoration.underline) : ts),
      overflow: TextOverflow.clip,
    );

    if (onPressed != null) {
      txt = GestureDetector(
        onTap: onPressed,
        child: txt,
      );
    }

    return txt;
  }
}
