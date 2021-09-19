import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_header.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publications.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_viewmodel.dart';

class WidgetHubViewContent extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: viewModel.viewData.hub != null
                ? Column(
                    children: [
                      WidgetHubHeader(),
                      WidgetHubPublications(),
                    ],
                  )
                : ProgressBar(
                    alignment: ProgressBarAlignment.Center,
                  ),
          ),
        ),
        floatingActionButton: viewModel.isCurrentUser() || viewModel.onboarding
            ? FloatingActionButton(
                onPressed: viewModel.onFabPressed,
                child: Icon(
                  !viewModel.onboarding ? Icons.add : Icons.arrow_forward,
                  color: AppColors.black,
                ),
                backgroundColor: AppColors.primaryColor,

                // elevation: 0,
              )
            : null,
      );
}
