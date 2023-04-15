import 'package:doc_analyze/extension/text_style_extension.dart';
import 'package:doc_analyze/theme/font_sizes.dart';
import 'package:flutter/material.dart';
import 'fonts.dart';

class TextStyles {
  static const TextStyle lato = TextStyle(
    fontFamily: Fonts.lato,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1,
    fontFamilyFallback: [
      Fonts.emoji,
    ],
  );

  static const TextStyle quicksand = TextStyle(
    fontFamily: Fonts.quicksand,
    fontWeight: FontWeight.w400,
    fontFamilyFallback: [
      Fonts.emoji,
    ],
  );

  static TextStyle get t1 => quicksand.bold.size(FontSizes.s24).letterSpace(.7);

  static TextStyle get t2 => lato.bold.size(FontSizes.s12).letterSpace(.4);

  static TextStyle get h1 => lato.bold.size(FontSizes.s18);

  static TextStyle get h2 => lato.bold.size(FontSizes.s12);

  static TextStyle get body1 => lato.size(FontSizes.s14);

  static TextStyle get body2 => lato.size(FontSizes.s12);

  static TextStyle get body3 => lato.size(FontSizes.s11);

  static TextStyle get callout => quicksand.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get calloutFocus => callout.bold;

  static TextStyle get btn => quicksand.bold.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get btnSelected => quicksand.size(FontSizes.s14).letterSpace(1.75);

  static TextStyle get footnote => quicksand.bold.size(FontSizes.s11);

  static TextStyle get caption => lato.size(FontSizes.s11).letterSpace(.3);
}
