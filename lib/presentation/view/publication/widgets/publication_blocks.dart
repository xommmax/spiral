import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

/*
  Media Block
 */

class MediaBlock extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    if (viewModel.publication!.mediaUrls.isEmpty) return SizedBox.shrink();

    List<RemoteMediaFile> mediaFiles = [];
    for (int i = 0; i < viewModel.publication!.mediaUrls.length; i++) {
      String mediaUrl = viewModel.publication!.mediaUrls[i];
      switch (getUrlType(mediaUrl)) {
        case UrlType.IMAGE:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: viewModel.publication!.previewUrls[i],
            type: MediaType.image,
          ));
          break;
        case UrlType.VIDEO:
          mediaFiles.add(RemoteMediaFile(
            path: mediaUrl,
            previewPath: viewModel.publication!.previewUrls[i],
            type: MediaType.video,
          ));
          break;
        case UrlType.UNKNOWN:
          throw ArgumentError(Strings.unknownMediaType);
      }
    }
    if (viewModel.publication!.viewType == MediaViewType.carousel) {
      return WidgetPublicationMediaCarouselPreview(mediaFiles);
    } else if (viewModel.publication!.viewType == MediaViewType.grid) {
      return WidgetPublicationMediaGridPreview(mediaFiles);
    } else {
      throw ArgumentError(Strings.unknownMediaType);
    }
  }
}

/*
  Text Block
 */

class TextBlock extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: quill.QuillEditor.basic(
        controller: viewModel.textController!,
        readOnly: true,
      ),
    );
  }
}

/*
  Link Block
 */

class LinkBlock extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: AppColors.linkText,
            ),
            SizedBox(width: 4),
            new Text(
              viewModel.publication!.link!,
              style: TextStyle(
                color: AppColors.linkText,
              ),
            ),
          ],
        ),
      ),
      onTap: () => launch(viewModel.publication!.link!).catchError(
          (e) => AppSnackBar.showSnackBarError(Strings.errorCouldNotLaunchUrl)),
    );
  }
}

/*
    File Block
 */

class FileBlock extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.accentColor, shape: BoxShape.circle),
              child: Icon(
                Icons.insert_drive_file,
                color: AppColors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.getAttachedFileName(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: viewModel.downloadAttachedFile,
    );
  }
}
