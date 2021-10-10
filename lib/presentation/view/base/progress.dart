import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';

class ActionProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
