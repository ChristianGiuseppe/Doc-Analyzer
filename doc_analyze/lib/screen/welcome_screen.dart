import 'dart:convert';
import 'dart:io';

import 'package:doc_analyze/screen/image_preview.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:doc_analyze/extension/string_extension.dart';
import 'package:doc_analyze/extension/text_style_extension.dart';
import 'package:doc_analyze/theme/app_color.dart';
import 'package:doc_analyze/theme/corners.dart';
import 'package:doc_analyze/theme/sizes.dart';
import 'package:doc_analyze/theme/text_style.dart';
import 'package:doc_analyze/widgets/add_button.dart';
import 'package:doc_analyze/widgets/clickable_text.dart';
import 'package:doc_analyze/widgets/file_analyzed.dart';
import 'package:doc_analyze/widgets/logo.dart';

import '../theme/page_break.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  XFile? xFileSelected;
  String? base64analyzed;
  List<FileSystemEntity> filesAnalyzed = [];
  bool isLoading = true;

  @override
  void initState() {
    getApplicationDocumentsDirectory().then((value) {
      final dir = Directory('${value.path}/doc_analyzer_patients');

      dir.list(recursive: true).forEach((element) {
        if (element.path.contains('.jpg')) {
          filesAnalyzed.add(element);
        }
        isLoading = false;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double columnBreakPt = PageBreaks.tabletLandscape - 100;

    final twoColumnMode = MediaQuery.of(context).size.width > columnBreakPt;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            Visibility(
              visible: twoColumnMode,
              child: Flexible(
                flex: 2,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(
                        color: AppColorDark.accent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Corners.s10),
                            bottomRight: Radius.circular(Corners.s10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LogoDocAnalyzer(),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Doc Analyzer",
                                style:
                                    TextStyles.h1.bold.textColor(Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Doc Analyzer è un software innovativo che utilizza l'Intelligenza Artificiale per identificare i tumori all'interno delle foto istologiche, offrendo un supporto importante ai medici e agli oncologi nella diagnosi precoce e accurata del cancro.",
                                style: TextStyles.callout.regular
                                    .textColor(Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const ClickableText('Privacy e policy', underline: true)
                      ],
                    )),
              ),
            ),
            Expanded(
                flex: twoColumnMode ? 6 : 1,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        twoColumnMode
                            ? Container(
                                height: Sizes.iconSize,
                              )
                            : const LogoDocAnalyzer(
                                colorType: ColorLogoType.green,
                              ),
                        Text(
                          "Benvenuto a  Doc Analyzer",
                          style:
                              TextStyles.t1.bold.textColor(AppColorDark.accent),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Aggiungi l'immagine che vuoi che l' IA deve analizzare ",
                          style: TextStyles.body1.regular,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        isLoading
                            ? const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator())
                            : SingleChildScrollView(
                                child: Container(
                                  height: twoColumnMode
                                      ? MediaQuery.of(context).size.height * 0.8
                                      : MediaQuery.of(context).size.height *
                                          0.7,
                                  padding: twoColumnMode
                                      ? EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15)
                                      : EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.06),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4),
                                    itemCount: filesAnalyzed.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FileAnalyzed(
                                          fileName:
                                              filesAnalyzed[index].fileName!,
                                          doubleTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ImagePreview(
                                                    path: filesAnalyzed[index]
                                                        .path,
                                                  );
                                                });
                                          }
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           ImagePreview(
                                          //             path: filesAnalyzed[index]
                                          //                 .path,
                                          //           )),
                                          // );

                                          );
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 8), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionButton(
                              image: Icons.add,
                              text: 'Nuovo Paziente',
                              onPressed: () async =>
                                  await _openImageFile(context),
                            ),
                            ActionButton(
                                enabled: xFileSelected != null,
                                image: Icons.search_outlined,
                                text: 'Analizza',
                                onPressed: () async => await _analyzeImage()),
                            ActionButton(
                                enabled: base64analyzed != null,
                                image: Icons.download,
                                text: 'Scarica Immagine',
                                onPressed: () async => await _downloadImage()),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _openImageFile(BuildContext context) async {
    // #docregion SingleOpen
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['tiff', 'tif'],
    );
    xFileSelected = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    // #enddocregion SingleOpen
    if (xFileSelected == null) {
      // Operation was canceled by the user.
      return;
    }

    setState(() {});

    final String filePath = xFileSelected!.path;
  }

  Future<void> _analyzeImage() async {
    if (xFileSelected == null) {
      return;
    }

    final bytesImage = await xFileSelected!.readAsBytes();
    String img64 = base64Encode(bytesImage);
    Map data = {'image': img64};
    final response = await http.post(
        Uri.parse('http://192.168.1.139:3000/analyze'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data));

    if (response.statusCode == 200) {
      base64analyzed = response.body;
    }

    setState(() {});
    return;
  }

  Future<void> _downloadImage() async {
    if (base64analyzed == null) {
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/doc_analyzer_patients/${xFileSelected!.name}.jpg');

    // Encode the image to JPG and write it to the file.
    await file.writeAsBytes(base64Decode(base64analyzed!));
    return;
  }
}
