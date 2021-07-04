import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_images_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_new_publication.dart';
import 'input_field_new_publication.dart';

class WidgetNewPublicationContent
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Scaffold(
        appBar: AppBarNewPublication(),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanDown: (_) =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputFieldNewPublication(),
                            WidgetNewPublicationImagesList()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: double.maxFinite,
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                )
              ],
            ),
          ),
          bottom: false,
        ),
      );
}
