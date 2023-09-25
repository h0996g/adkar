import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView(
      {Key? key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;
  @override
  Widget build(BuildContext context) {
    return Showcase(

        // disableDefaultTargetGestures: true,
        // blurValue: 5,
        movingAnimationDuration: const Duration(milliseconds: 3000),
        targetPadding: const EdgeInsets.all(5),
        scaleAnimationCurve: Curves.easeInBack,
        targetBorderRadius: BorderRadius.circular(10),
        descriptionAlignment: TextAlign.right,
        titleAlignment: TextAlign.right,
        titleTextDirection: TextDirection.rtl,
        key: globalKey,
        title: title,
        description: description,
        titleTextStyle: const TextStyle(
          color: Colors.red,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        descTextStyle: const TextStyle(
          fontSize: 15,
        ),

        // shapeBorder: shapeBorder,
        child: child);
  }
}
