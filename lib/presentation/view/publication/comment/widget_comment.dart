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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              onTap: () => comment.parentCommentId == null
                  ? {
                      setCommentToReply!(comment),
                      viewModel.onReplyToThisCommentClicked(),
                    }
                  : null,
              leading: InkWell(
                  child: WidgetProfilePhoto(
                    photoUrl: comment.user.photoURL,
                    radius: 20,
                  ),
                  onTap: () => viewModel.onAvatarPressed(comment.user)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user.name ??
                        comment.user.email ??
                        comment.user.phoneNumber ??
                        Strings.unknownUser,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    comment.text,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (viewModel.areRepliesNotEmpty() || comment.repliesCount != 0)
            GestureDetector(
              onTap: viewModel.onShowRepliesClicked,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.fromLTRB(72, 0, 8, 0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 1,
                      width: 16,
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
            ),
          if (viewModel.isRepliesShown)
            viewModel.replies != null && viewModel.replies!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.fromLTRB(40, 8, 8, 0),
                    child: WidgetComments(viewModel.replies!),
                  )
                : ProgressBar(),
        ],
      );
}
