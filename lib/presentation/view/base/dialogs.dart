import 'package:dairo/presentation/res/strings.dart';
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
