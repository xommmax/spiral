import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/media/widget_publication_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetNewPublicationMediaGridPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: viewModel.viewData.mediaFiles
            .map((file) => _bindItem(
                  viewModel.viewData.mediaFiles,
                  viewModel.viewData.mediaFiles.indexOf(file),
                ))
            .toList(),
        crossAxisCount: 3,
      );
}

class WidgetNewPublicationMediaCarouselPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      CarouselSlider(
          items: viewModel.viewData.mediaFiles
              .map((file) => _bindItem(
                    viewModel.viewData.mediaFiles,
                    viewModel.viewData.mediaFiles.indexOf(file),
                  ))
              .toList(),
          options: CarouselOptions(
            aspectRatio: 1,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            disableCenter: true,
            // onPageChanged: callbackFunction,
          ));
}

Widget _bindItem(List<MediaFile> files, int position) =>
    WidgetPublicationMediaPreview(files, position, local: true);

enum MediaPreviewType {
  GRID,
  CAROUSEL,
}
