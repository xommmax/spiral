import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/default_widgets.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/publication/comment/comment_viewmodel.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetComment extends ViewModelBuilderWidget<CommentViewModel> {
  final Comment comment;
  final Function(Comment)? setCommentToReply;

  const WidgetComment(
    this.comment, {
    required this.setCommentToReply,
    Key? key,
  }) : super(key: key);

  @override
  CommentViewModel viewModelBuilder(BuildContext context) => CommentViewModel(
        publicationId: comment.publicationId,
        parentCommentId: comment.id,
      );

  @override
  Widget builder(
          BuildContext context, CommentViewModel viewModel, Widget? child) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () => comment.parentCommentId == null
                ? {
                    setCommentToReply!(comment),
                    viewModel.onReplyToThisCommentClicked(),
                  }
                : null,
            leading: SizedBox(
              height: 40,
              width: 40,
              child: WidgetProfilePhoto(
                photoUrl: comment.user.photoURL,
                radius: 70,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user.name ??
                      comment.user.email ??
                      comment.user.phoneNumber ??
                      Strings.unknownUser,
                  style: TextStyles.black12Bold,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                ),
                Text(
                  comment.text,
                  style: TextStyles.black12,
                ),
              ],
            ),
          ),
          viewModel.areRepliesNotEmpty() || comment.repliesCount != 0
              ? GestureDetector(
                  onTap: viewModel.onShowRepliesClicked,
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          height: 1,
                          width: 25,
                          color: AppColors.gray,
                        ),
                        Text(
                          !viewModel.isRepliesShown
                              ? '${Strings.showReplies} (${viewModel.replies != null ? viewModel.replies?.length : comment.repliesCount})'
                              : Strings.hideReplies,
                          style: TextStyles.gray14,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
          viewModel.isRepliesShown
              ? viewModel.replies != null && viewModel.replies!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(40, 8, 8, 0),
                      child: WidgetComments(viewModel.replies!),
                    )
                  : ProgressBar()
              : SizedBox.shrink()
        ],
      );
}
