import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_publication.dart';

class WidgetPublicationViewContent
    extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) =>
      Scaffold(
        appBar: AppBarPublication(),
        body: SafeArea(
          child: viewModel.isDataReady()
              ? WidgetPublication()
              : ProgressBar(
                  alignment: ProgressBarAlignment.Center,
                ),
          bottom: false,
        ),
      );
}
