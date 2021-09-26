import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comment_input_field.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_comments.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
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
  final MediaViewType viewType;

  const WidgetPublicationMedia(this.mediaUrls, this.viewType, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mediaUrls.isEmpty) return SizedBox.shrink();
    List<MediaFile> mediaFiles = mediaUrls.map((url) {
      switch (getUrlType(url)) {
        case UrlType.IMAGE:
          return MediaFile(path: url, type: MediaType.image);
        case UrlType.VIDEO:
          return MediaFile(path: url, type: MediaType.video);
        case UrlType.UNKNOWN:
          throw ArgumentError(Strings.unknownMediaType);
      }
    }).toList();
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
        children: [
          Row(
            children: [
              WidgetProfilePhoto(
                photoUrl: viewModel.user?.photoURL,
                width: 22,
                height: 22,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4),
              ),
              InkWell(
                child: Text(
                  viewModel.user?.name ??
                      viewModel.user?.username ??
                      viewModel.user?.email ??
                      '',
                  style: TextStyles.black12,
                ),
                onTap: viewModel.onUserClicked,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
          ),
          Row(
            children: [
              WidgetProfilePhoto(
                photoUrl: viewModel.hub?.pictureUrl,
                width: 22,
                height: 22,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4),
              ),
              InkWell(
                child: Text(
                  viewModel.hub?.name ?? '',
                  style: TextStyles.black12,
                ),
                onTap: viewModel.onHubClicked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
