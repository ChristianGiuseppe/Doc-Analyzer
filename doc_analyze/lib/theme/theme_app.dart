import 'package:doc_analyze/theme/app_color.dart';
import 'package:doc_analyze/theme/text_styled_input.dart';
import 'package:flutter/material.dart';

import 'color_utilis.dart';

enum ThemeType {
  docAnalyzerGreenLight,
  docAnalyzerGreenDark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.docAnalyzerGreenLight;

  bool isDark;
  Color bg1; //
  Color surface; //
  Color bg2;
  Color accent1;
  Color accent1Dark;
  Color accent1Darker;
  Color accent2;
  Color accent3;
  Color grey;
  Color greyStrong;
  Color greyWeak;
  Color error;
  Color focus;

  Color txt;
  Color accentTxt;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.bg1,
    required this.surface,
    required this.bg2,
    required this.accent1,
    required this.accent1Dark,
    required this.accent1Darker,
    required this.accent2,
    required this.accent3,
    required this.grey,
    required this.greyStrong,
    required this.greyWeak,
    required this.error,
    required this.focus,
    required this.txt,
    required this.accentTxt,
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.docAnalyzerGreenLight:
        return AppTheme(
          isDark: false,
          txt: AppColorLight.accent,
          accentTxt: AppColorLight.accentText,
          bg1: AppColorLight.background,
          bg2: AppColorLight.background2,
          surface: AppColorLight.surface,
          accent1: AppColorLight.accent,
          accent1Dark: AppColorLight.accentDark,
          accent1Darker: AppColorLight.accentDarker,
          accent2: AppColorLight.accent2,
          accent3: AppColorLight.accent3,
          greyWeak: AppColorLight.greyWeak,
          grey: AppColorLight.grey,
          greyStrong: AppColorLight.greyStrong,
          error: AppColorLight.error,
          focus: AppColorLight.focus,
        );

      case ThemeType.docAnalyzerGreenDark:
           return AppTheme(
          isDark: false,
          txt: AppColorDark.accent,
          accentTxt: AppColorDark.accentText,
          bg1: AppColorDark.background,
          bg2: AppColorDark.background2,
          surface: AppColorDark.surface,
          accent1: AppColorDark.accent,
          accent1Dark: AppColorDark.accentDark,
          accent1Darker: AppColorDark.accentDarker,
          accent2: AppColorDark.accent2,
          accent3: AppColorDark.accent3,
          greyWeak: AppColorDark.greyWeak,
          grey: AppColorDark.grey,
          greyStrong: AppColorDark.greyStrong,
          error: AppColorDark.error,
          focus: AppColorDark.focus,
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: accent1Darker,
          secondary: accent2,
          secondaryContainer: ColorUtils.shiftHsl(accent2, -.2),
          background: bg1,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error),
    );
    return t.copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: ThinUnderlineBorder(),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: greyWeak,
            selectionHandleColor: Colors.transparent,
            cursorColor: accent1,
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: accent1,
        ),
        highlightColor: accent1);
  }

  Color shift(Color c, double d) => ColorUtils.shiftHsl(c, d * (isDark? -1 : 1));
}