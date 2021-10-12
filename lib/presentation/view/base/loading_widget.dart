import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/tools/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final ProgressBarAlignment alignment;

  ProgressBar({this.alignment = ProgressBarAlignment.Default});

  @override
  Widget build(BuildContext context) {
    final progressIndicator = CircularProgressIndicator(color: AppColors.white);
    return alignment == ProgressBarAlignment.Center
        ? Container(
            height: getScreenHeight(context),
            child: Center(
              child: progressIndicator,
            ),
          )
        : progressIndicator;
  }
}

enum ProgressBarAlignment { Default, Center }
