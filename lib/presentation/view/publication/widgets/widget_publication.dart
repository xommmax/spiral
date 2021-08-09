import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetPublication extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.publication!.mediaUrls.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: WidgetHubPublicationMedia(
                                viewModel.publication!.mediaUrls),
                          )
                        : SizedBox.shrink(),
                    viewModel.publication?.text != null &&
                            viewModel.publication!.text!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 18,
                              left: 12,
                            ),
                            child: Text(viewModel.publication!.text!),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: viewModel.comments != null
                          ? WidgetComments(
                              viewModel.comments!,
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
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
                      style: TextStyles.robotoBlack14,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: viewModel.onSendCommentClicked,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
