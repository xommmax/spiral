import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../publication_viewmodel.dart';

class WidgetCommentBottomInputField
    extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          viewModel.commentToReply != null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.gray, width: 1),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 2,
                        color: AppColors.gray,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: Strings.yourAnswer,
                                style: TextStyles.gray14,
                                children: [
                                  TextSpan(
                                      text:
                                          viewModel.commentToReply!.user.name ??
                                              Strings.unknownUser,
                                      style: TextStyles.blue14)
                                ],
                              ),
                            ),
                            Text(
                              viewModel.commentToReply!.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => viewModel.setCommentToReply(null),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray, width: 1),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 4,
              right: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: viewModel.commentsTextController,
                    onChanged: (t) => viewModel.notifyListeners(),
                    decoration: InputDecoration(
                      hintText: Strings.addComment,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyles.black14,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_rounded,
                      color: viewModel.commentsTextController.text.isEmpty
                          ? AppColors.gray
                          : AppColors.black),
                  onPressed: viewModel.onSendCommentClicked,
                ),
              ],
            ),
          ),
        ],
      );
}
