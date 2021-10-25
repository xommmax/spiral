import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/default_images.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comment_input_field.dart';
import 'package:dairo/presentation/view/publication/comment/widget_comments.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_blocks.dart';
import 'package:flutter/cupertino.dart';
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
                    WidgetPublicationHeader(),
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

class WidgetPublicationHeader extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: Row(
                  children: [
                    WidgetProfilePhoto(
                      photoUrl: viewModel.user?.photoURL,
                      radius: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.user?.name ??
                          viewModel.user?.username ??
                          viewModel.user?.email ??
                          '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: viewModel.onUserClicked,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(Strings.inWord,
                    style: TextStyle(
                      color: AppColors.white,
                    )),
              ),
              InkWell(
                child: Row(
                  children: [
                    WidgetHubPhoto(
                      photoUrl: viewModel.hub?.pictureUrl,
                      radius: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.hub?.name ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: viewModel.onHubClicked,
              ),
            ],
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.more_vert, color: AppColors.white),
            ),
            onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => OptionsBottomSheet(
                      onReport: viewModel.isCurrentUserPublication()
                          ? null
                          : () => viewModel.onReport(),
                      onDelete: viewModel.isCurrentUserPublication()
                          ? () => viewModel.onDelete()
                          : null,
                    )),
          ),
        ],
      ),
    );
  }
}
