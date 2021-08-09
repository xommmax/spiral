import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_header.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publications.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_viewmodel.dart';
import 'appbar_hub.dart';

class WidgetHubViewContent extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Scaffold(
        appBar: AppBarHub(),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                WidgetHubHeader(),
                WidgetHubPublications(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onCreatePublicationClicked,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
          // elevation: 0,
        ),
      );
}
