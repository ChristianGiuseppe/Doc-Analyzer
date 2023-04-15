import 'package:doc_analyze/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ColorLogoType{
  white,
  green,
}


class LogoDocAnalyzer extends StatelessWidget {

  const LogoDocAnalyzer({super.key, this.colorType = ColorLogoType.white});
  final ColorLogoType colorType;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 8, right: 16, left: 16),
      child: 
          SvgPicture.asset(
            'assets/svg/logo_${colorType.name}.svg',
          
            width: Sizes.iconSize,
            height: Sizes.iconSize,
          ),
    );
  }
}
