import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comment_input_field.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comments.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_blocks.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class PublicationWidget extends ViewModelWidget<PublicationViewModel> {
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
                    PublicationHeaderWidget(),
                    if (viewModel.publication!.mediaUrls.isNotEmpty)
                      MediaBlock(),
                    if (viewModel.publication!.text != null &&
                        viewModel.publication!.text!.isNotEmpty)
                      TextBlock(),
                    if (viewModel.publication!.attachedFileUrl != null)
                      FileBlock(),
                    if (viewModel.publication!.link != null) LinkBlock(),
                    Divider(
                      thickness: 0.3,
                      color: AppColors.darkGray,
                      indent: 8,
                      endIndent: 8,
                    ),
                    if (viewModel.comments != null &&
                        viewModel.comments!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8, top: 4),
                        child: Text(
                          Strings.comments,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    if (viewModel.comments != null &&
                        viewModel.comments!.isNotEmpty)
                      WidgetComments(
                        viewModel.comments!,
                        setCommentToReply: viewModel.setCommentToReply,
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
