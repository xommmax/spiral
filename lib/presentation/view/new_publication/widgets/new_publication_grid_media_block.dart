import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/new_publication_media_preview.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetNewPublicationMediaGridPreview
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    switch (viewModel.viewData.mediaFiles.length) {
      case 1:
        return _buildSingle(0);
      case 2:
        return _buildTwoInRow(0, 1);
      case 3:
        return _buildThreeInRow(0, 1, 2);
      case 4:
        return Column(children: [
          _buildTwoInRow(0, 1),
          _buildTwoInRow(2, 3),
        ]);
      case 5:
        return Column(children: [
          _buildTwoInRow(0, 1),
          _buildThreeInRow(2, 3, 4),
        ]);
      case 6:
        return Column(children: [
          _buildThreeInRow(0, 1, 2),
          _buildThreeInRow(3, 4, 5),
        ]);
      case 7:
        return Column(children: [
          _buildTwoInRow(0, 1),
          _buildTwoInRow(2, 3),
          _buildThreeInRow(4, 5, 6),
        ]);
      case 8:
        return Column(children: [
          _buildTwoInRow(0, 1),
          _buildThreeInRow(2, 3, 4),
          _buildThreeInRow(5, 6, 7),
        ]);
      case 9:
        return Column(children: [
          _buildThreeInRow(0, 1, 2),
          _buildThreeInRow(3, 4, 5),
          _buildThreeInRow(6, 7, 8),
        ]);
      default:
        return SizedBox.shrink();
    }
  }

  _buildSingle(int index) => AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.all(1),
          child: WidgetNewPublicationMediaPreview(index),
        ),
      );

  _buildTwoInRow(int index0, int index1) => AspectRatio(
        aspectRatio: 2,
        child: Row(
          children: [
            _buildSingle(index0),
            _buildSingle(index1),
          ],
        ),
      );

  _buildThreeInRow(int index0, int index1, int index2) => AspectRatio(
        aspectRatio: 3,
        child: Row(
          children: [
            _buildSingle(index0),
            _buildSingle(index1),
            _buildSingle(index2),
          ],
        ),
      );
}
