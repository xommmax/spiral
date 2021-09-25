import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/input_field_new_publication.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_media_preview.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
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
                      onTap: () => openMediaPicker(context, viewModel),
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
      floatingActionButton: viewModel.hubId != null
          ? FloatingActionButton(
              onPressed: viewModel.onDonePressed,
              child: Icon(
                Icons.check,
                color: AppColors.black,
              ),
              backgroundColor: AppColors.primaryColor,
            )
          : _WidgetPopUpHubsSelectionMenu(
              hubs: viewModel.hubs,
              onHubSelected: viewModel.onHubSelected,
            ),
    );
  }

  void openMediaPicker(
      BuildContext context, NewPublicationViewModel viewModel) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MediaPicker(
            mediaList: viewModel.mediaList,
            onPick: (selectedList) {
              if (selectedList.length > NewPublicationViewModel.maxMediaSize) {
                AppSnackBar.showSnackBarError(Strings.errorLimitMaxMediaSize);
                return;
              }
              viewModel.updateMediaList(selectedList);
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            mediaCount: MediaCount.multiple,
            mediaType: MediaType.all,
            decoration: PickerDecoration(
              actionBarPosition: ActionBarPosition.top,
              albumTitleStyle: TextStyle(
                color: AppColors.black,
              ),
              albumTextStyle: TextStyle(
                color: AppColors.black,
              ),
              completeTextStyle: TextStyle(
                color: AppColors.black,
              ),
              completeButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.lightGray),
              ),
              cancelIcon: Icon(Icons.arrow_back),
              completeText: 'Done',
            ),
          );
        });
  }
}

class _WidgetPopUpHubsSelectionMenu extends StatelessWidget {
  final List<Hub> hubs;
  final Function(String) onHubSelected;

  _WidgetPopUpHubsSelectionMenu({
    required this.hubs,
    required this.onHubSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = hubs
        .map(
          (hub) => PopupMenuItem(
            value: hub.id,
            child: _WidgetHubItem(hub),
          ),
        )
        .toList();
    items.insert(
      0,
      PopupMenuItem(
        value: NewPublicationViewModel.createHubItemValue,
        child: _WidgetCreateHubItem(),
      ),
    );

    return Container(
      child: PopupMenuButton(
        onSelected: onHubSelected,
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.check,
            color: AppColors.black,
          ),
        ),
        itemBuilder: (context) => items,
      ),
    );
  }
}

class _WidgetHubItem extends StatelessWidget {
  final Hub hub;

  const _WidgetHubItem(this.hub, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        key: ValueKey(hub.id),
        leading: SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              imageUrl: hub.pictureUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(hub.name),
      );
}

class _WidgetCreateHubItem extends StatelessWidget {
  const _WidgetCreateHubItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Icon(
              Icons.add,
              color: AppColors.black,
            ),
          ),
        ),
        title: Text(Strings.createHub),
      );
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
