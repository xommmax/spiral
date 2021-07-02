import 'dart:io';

import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetNewPublicationImagesList
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      viewModel.viewData.imagesList.length != 0
          ? GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: viewModel.viewData.imagesList
                  .map((path) => _bindItem(viewModel,
                      viewModel.viewData.imagesList.indexOf(path), path))
                  .toList(),
              crossAxisCount: 4,
            )
          : SizedBox.shrink();

  Widget _bindItem(
          NewPublicationViewModel viewModel, int position, String path) =>
      GestureDetector(
        onTap: () => viewModel.onItemRemoveClicked(position),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
