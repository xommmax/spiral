import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetAttachmentsPanel extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Container(
        width: double.maxFinite,
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: viewModel.onVideoGallerySelected,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.video_camera_back_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            GestureDetector(
              onTap: viewModel.onVideoCameraSelected,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.video_call_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            GestureDetector(
              onTap: viewModel.onGallerySelected,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.photo_library_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            GestureDetector(
              onTap: viewModel.onCameraSelected,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
            ),
          ],
        ),
      );
}
