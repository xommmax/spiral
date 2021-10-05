import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
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
                    if (viewModel.publication!.text != null) TextBlock(),
                    if (viewModel.publication!.link != null) LinkBlock(),
                    if (viewModel.publication!.attachedFileUrl != null)
                      FileBlock(),
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
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.user?.name ??
                          viewModel.user?.username ??
                          viewModel.user?.email ??
                          '',
                      style: TextStyle(
                        color: AppColors.black,
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
                child: Text(Strings.inWord),
              ),
              InkWell(
                child: Row(
                  children: [
                    WidgetProfilePhoto(
                      photoUrl: viewModel.hub?.pictureUrl,
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.hub?.name ?? '',
                      style: TextStyle(
                        color: AppColors.black,
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
              child: Icon(Icons.more_vert),
            ),
            onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => OptionsBottomSheet(viewModel.onReport)),
          ),
        ],
      ),
    );
  }
}
