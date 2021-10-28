import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/tools/file_helper.dart';
import 'package:dairo/presentation/view/tools/media_type_extractor.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/widgets/simple_viewer.dart';
import 'package:stacked/stacked.dart';

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
      child: QuillSimpleViewer(
        controller: viewModel.textController!,
        readOnly: true,
        truncate: false,
        padding: EdgeInsets.zero,
        customStyles: getPublicationTextStyle(context),
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
      onTap: viewModel.onLinkClicked,
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
            Expanded(
              child: Text(
                getAttachedFileName(viewModel.publication!),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      onTap: viewModel.onFileClicked,
    );
  }
}
