import 'dart:io';

import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_video_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetNewPublicationMediasList
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      viewModel.viewData.publication.mediaFiles.length != 0
          ? GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: viewModel.viewData.publication.mediaFiles
                  .map((file) => _bindItem(
                      viewModel,
                      viewModel.viewData.publication.mediaFiles.indexOf(file),
                      file))
                  .toList(),
              crossAxisCount: 4,
            )
          : SizedBox.shrink();

  Widget _bindItem(
          NewPublicationViewModel viewModel, int position, MediaFile file) =>
      GestureDetector(
        onTap: () => viewModel.onMediaItemRemoveClicked(position),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: file.type == MediaType.image
                ? Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  )
                : WidgetVideoPreview(filePath: file.path),
          ),
        ),
      );
}
