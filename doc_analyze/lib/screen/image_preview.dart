import 'dart:io';

import 'package:doc_analyze/theme/corners.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Corners.s10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Image.file(File(path)),
    );
  }
}
