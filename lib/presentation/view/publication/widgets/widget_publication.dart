import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comment_input_field.dart';
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
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: WidgetHubPublicationMedia(
                                  viewModel.publication!.mediaUrls),
                            ),
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
                              setCommentToReply: viewModel.setCommentToReply,
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            WidgetCommentBottomInputField(),
          ],
        ),
      );
}
