import 'package:doc_analyze/theme/app_color.dart';
import 'package:doc_analyze/theme/sizes.dart';
import 'package:doc_analyze/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileAnalyzed extends StatelessWidget {
  String fileName;
  VoidCallback doubleTap;
  FileAnalyzed({super.key, required this.fileName, required this.doubleTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppColorDark.accent3,
      radius: 8.0,
      onDoubleTap: doubleTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/file_jpg.svg',
              width: Sizes.iconSize,
              height: Sizes.iconSize,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              fileName,
              style: TextStyles.caption,
            )
          ],
        ),
      ),
    );
  }
}
