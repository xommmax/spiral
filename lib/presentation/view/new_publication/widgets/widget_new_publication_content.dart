import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_attachments_panel.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_medias_list.dart';
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
          bottom: false,
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
                            WidgetNewPublicationMediasList()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                WidgetAttachmentsPanel(),
                Container(
                  height: MediaQuery.of(context).padding.bottom,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: viewModel.hubId != null
            ? FloatingActionButton(
                onPressed: viewModel.onDonePressed,
                child: Icon(
                  viewModel.isBusy ? Icons.file_upload : Icons.check,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.primaryColor,
              )
            : _WidgetPopUpHubsSelectionMenu(
                hubs: viewModel.hubs,
                onHubSelected: viewModel.onHubSelected,
              ),
      );
}

class _WidgetPopUpHubsSelectionMenu extends StatelessWidget {
  final List<Hub> hubs;
  final Function(String) onHubSelected;

  _WidgetPopUpHubsSelectionMenu({
    required this.hubs,
    required this.onHubSelected,
  });

  @override
  Widget build(BuildContext context) => Container(
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
              color: AppColors.white,
            ),
          ),
          itemBuilder: (context) => hubs
              .map(
                (hub) => PopupMenuItem(
                  value: hub.id,
                  child: _WidgetHubItem(hub),
                ),
              )
              .toList(),
        ),
      );
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
