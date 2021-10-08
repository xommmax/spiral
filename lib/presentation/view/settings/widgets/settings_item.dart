import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetSettingsItem extends StatelessWidget {
  final String text;
  final VoidCallback onItemClicked;

  WidgetSettingsItem({
    required this.text,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onItemClicked(),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 8, 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: AppColors.black, fontSize: 15),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black,
              )
            ],
          ),
        ),
      );
}
