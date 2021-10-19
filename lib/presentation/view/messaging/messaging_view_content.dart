import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/messaging/messaging_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class MessagingViewContent extends ViewModelWidget<MessagingViewModel> {
  @override
  Widget build(BuildContext context, MessagingViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(Strings.messages, style: TextStyles.toolbarTitle),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 56),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  Strings.messages,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  Strings.messagingDesc,
                  style: TextStyle(
                    color: AppColors.lightGray,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ),
      );
}
