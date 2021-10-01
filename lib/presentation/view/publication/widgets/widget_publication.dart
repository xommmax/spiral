import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comment_input_field.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comments.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
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
                    viewModel.publication!.mediaUrls.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: WidgetPublicationMedia(
                                viewModel.publication!.mediaUrls,
                                viewModel.publication!.previewUrls,
                                viewModel.publication!.viewType),
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

class WidgetPublicationMedia extends StatelessWidget {
  final List<String> mediaUrls;
  final List<String> previewUrls;
  final MediaViewType viewType;

  const WidgetPublicationMedia(this.mediaUrls, this.previewUrls, this.viewType,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mediaUrls.isEmpty) return SizedBox.shrink();

    List<RemoteMediaFile> mediaFiles = [];
    for (int i = 0; i < mediaUrls.length; i++) {
      String mediaUrl = mediaUrls[i];
      switch (getUrlType(mediaUrl)) {
        case UrlType.IMAGE:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: previewUrls[i],
            type: MediaType.image,
          ));
          break;
        case UrlType.VIDEO:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: previewUrls[i],
            type: MediaType.video,
          ));
          break;
        case UrlType.UNKNOWN:
          throw ArgumentError(Strings.unknownMediaType);
      }
    }
    if (viewType == MediaViewType.carousel) {
      return WidgetPublicationMediaCarouselPreview(mediaFiles);
    } else if (viewType == MediaViewType.grid) {
      return WidgetPublicationMediaGridPreview(mediaFiles);
    } else {
      throw ArgumentError(Strings.unknownMediaType);
    }
  }
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
