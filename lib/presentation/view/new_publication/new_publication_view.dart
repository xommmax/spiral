import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/new_publication/widgets/appbar_new_publication.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_content.dart';
import 'package:flutter/widgets.dart';

import 'new_publication_viewmodel.dart';

class NewPublicationView extends StandardBaseView<NewPublicationViewModel> {
  NewPublicationView()
      : super(
          NewPublicationViewModel(),
        );

  @override
  Widget getContent(BuildContext context) => SafeArea(
        child: WidgetNewPublicationContent(),
        bottom: false,
      );

  @override
  PreferredSizeWidget? getAppBar(BuildContext context) =>
      AppBarNewPublication();
}
