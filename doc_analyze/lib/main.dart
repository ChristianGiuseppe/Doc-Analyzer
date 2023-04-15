import 'dart:io';

import 'package:doc_analyze/screen/welcome_screen.dart';
import 'package:doc_analyze/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  await Directory('${directory.path}/doc_analyzer_patients').create();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Doc Analyzer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.fromType(ThemeType.docAnalyzerGreenDark).themeData,
        home: const WelcomeScreen());
  }
}
