import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nengar/text_style.dart';

class NumberEditPageHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const NumberEditPageHeader({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
            child: PlatformText(
              title,
              textAlign: TextAlign.center,
              style: subTitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: PlatformText(
              subTitle,
              textAlign: TextAlign.center,
              style: subTitle2,
            ),
          ),
        ],
      ),
    );
  }
}
