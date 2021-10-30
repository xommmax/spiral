import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDialog {
  static showConfirmationDialog({
    required title,
    required description,
    cancelText = Strings.no,
    confirmText = Strings.yes,
    required Function() onConfirm,
  }) {
    showCupertinoDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                CupertinoDialogAction(
                  child: Text(cancelText),
                  onPressed: () => Get.back(),
                  isDefaultAction: true,
                ),
                CupertinoDialogAction(
                  child: Text(confirmText),
                  isDestructiveAction: true,
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                ),
              ],
            ));
  }

  static showChoiceDialog({
    required title,
    required description,
    required List<String> choices,
    required Function(String) onConfirm,
  }) {
    showCupertinoDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(description),
              actions: choices
                  .map(
                    (choice) => CupertinoDialogAction(
                      child: Text(choice),
                      onPressed: () {
                        Get.back();
                        onConfirm(choice);
                      },
                    ),
                  )
                  .toList(),
            ));
  }

  static showInformDialog({
    required title,
    required description,
  }) {
    showCupertinoDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                CupertinoDialogAction(
                  child: Text(Strings.ok),
                  onPressed: () => Get.back(),
                ),
              ],
            ));
  }

  static inviteFriends({
    Function()? confirm,
  }) =>
      showDialog(
        barrierDismissible: false,
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => _getInviteContent(confirm: confirm),
      );

  static _getInviteContent({
    Function()? confirm,
  }) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      backgroundColor: AppColors.darkAccentColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.close,
                size: 20,
                color: AppColors.white.withOpacity(0.5),
              ),
            ),
          ),
          Text(
            'Thank you',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.3,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ' for being our early user',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.6,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'We will turn to private access soon. Hurry up and invite your friends to join our community!',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.4,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 24),
          InkWell(
            onTap: () {
              Get.back();
              confirm?.call();
            },
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              color: AppColors.accentColor,
              padding: const EdgeInsets.all(0.0),
              child: Text(
                Strings.inviteFriends,
                style: TextStyles.black16Bold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsBottomSheet extends StatelessWidget {
  final Function? onReport;
  final Function? onBlock;
  final Function? onDelete;

  OptionsBottomSheet({this.onReport, this.onBlock, this.onDelete});

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: Text(Strings.options),
        actions: [
          if (onDelete != null)
            CupertinoActionSheetAction(
              child: Text(Strings.delete),
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
                onDelete!();
              },
            ),
          if (onReport != null)
            CupertinoActionSheetAction(
              child: Text(Strings.report),
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
                onReport!();
              },
            ),
          if (onBlock != null)
            CupertinoActionSheetAction(
              child: Text(Strings.block),
              isDestructiveAction: true,
              onPressed: () {
                Get.back();
                onBlock!();
              },
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(Strings.cancel),
          onPressed: () => Get.back(),
        ),
      );
}
