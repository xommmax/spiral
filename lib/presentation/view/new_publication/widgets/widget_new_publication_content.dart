import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/input_field_new_publication.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_new_publication.dart';

class WidgetNewPublicationContent
    extends ViewModelWidget<NewPublicationViewModel> {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) {
    var padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        Dimens.toolBarHeight;

    return Scaffold(
        appBar: AppBarNewPublication(),
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                if (viewModel.viewData.mediaFiles.length == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => viewModel.openMediaPicker(context),
                        child: Container(
                          height: height / 2,
                          child: Center(
                            child: Text(
                              "Attach the media",
                              style: TextStyle(color: AppColors.gray),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      InputFieldNewPublication(),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _WidgetSwitchMediaPreviewType(),
                      IndexedStack(
                        index: viewModel.mediaPreviewTypeIndex,
                        children: [
                          Column(
                            children: [
                              WidgetNewPublicationMediaCarouselPreview(),
                              InputFieldNewPublication(),
                            ],
                          ),
                          Column(
                            children: [
                              WidgetNewPublicationMediaGridPreview(),
                              InputFieldNewPublication(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onDonePressed,
          child: Icon(
            Icons.check,
            color: AppColors.black,
          ),
          backgroundColor: AppColors.primaryColor,
        ));
  }
}

class _WidgetSwitchMediaPreviewType
    extends ViewModelWidget<NewPublicationViewModel> {
  const _WidgetSwitchMediaPreviewType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.view_carousel_outlined),
              iconSize: 28,
              color: viewModel.mediaPreviewTypeIndex == 0
                  ? AppColors.black
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaPreviewTypeIndexChanged(0),
            ),
            IconButton(
              icon: Icon(Icons.grid_on),
              iconSize: 28,
              color: viewModel.mediaPreviewTypeIndex == 1
                  ? AppColors.black
                  : AppColors.gray,
              onPressed: () => viewModel.onMediaPreviewTypeIndexChanged(1),
            ),
          ],
        ),
      );
}
