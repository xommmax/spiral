import 'dart:ui';

import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDialog {
  static showConfirmationDialog({
    required String title,
    required Function(bool) onConfirm,
    String? description,
    String? cancelText,
    String? confirmText,
  }) =>
      _show(
          title: title,
          description: description,
          cancelText: cancelText,
          confirmText: confirmText,
          confirm: onConfirm);

  static _show({
    required String title,
    required Function(bool) confirm,
    String? description,
    String? cancelText,
    String? confirmText,
  }) =>
      showDialog(
        context: StackedService.navigatorKey!.currentState!.context,
        builder: (context) => _getContent(
            title: title,
            description: description,
            cancelText: cancelText,
            confirmText: confirmText,
            confirm: confirm),
      );

  static _getContent({
    required String title,
    required Function(bool) confirm,
    String? description,
    String? cancelText,
    String? confirmText,
  }) {
    final buttonOk = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.back();
        confirm(true);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          confirmText ?? Strings.ok,
          style: TextStyles.black16Bold,
          textAlign: TextAlign.center,
        ),
      ),
    );

    final buttonCancel = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.back();
        confirm(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          cancelText ?? Strings.cancel,
          style: TextStyles.black16Bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
    final titleWidget = Text(
      title,
      style: TextStyles.black16,
      textAlign: TextAlign.center,
    );
    return AlertDialog(
      title: titleWidget,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          description != null
              ? Text(
                  description,
                  textAlign: TextAlign.center,
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonCancel,
              buttonOk,
            ],
          ),
        ],
      ),
    );
  }
}
