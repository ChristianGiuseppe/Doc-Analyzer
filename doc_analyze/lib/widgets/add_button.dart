import 'package:doc_analyze/extension/text_style_extension.dart';
import 'package:doc_analyze/theme/app_color.dart';
import 'package:doc_analyze/theme/corners.dart';
import 'package:doc_analyze/theme/sizes.dart';
import 'package:flutter/material.dart';

import '../theme/text_style.dart';

class ActionButton extends StatefulWidget {
  const ActionButton(
      {super.key, required this.image, required this.text, this.onPressed, this.enabled = true});
  final IconData image;
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    TextStyle style = widget.enabled ? TextStyles.caption : TextStyles.caption.textColor(AppColorDark.grey);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(Corners.s5),
          onTapDown: (_) {
            if (widget.onPressed != null) widget.onPressed!();
            setState(() {
              isFocused = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isFocused = false;
            });
          },
          child: Container(
            width: Sizes.buttonSize,
            height: Sizes.buttonSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Corners.s5),
                border: Border.all(width: 2.0, color: widget.enabled ?  AppColorDark.accent:  AppColorDark.grey)),
            child: Icon(widget.image,
                color: widget.enabled ?  isFocused ? Colors.white : AppColorDark.accent : AppColorDark.grey),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(widget.text, style: style)
      ],
    );
  }
}
