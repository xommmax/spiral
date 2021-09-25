import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/strings.dart';
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
