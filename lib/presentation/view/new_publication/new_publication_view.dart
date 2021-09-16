import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/new_publication/widgets/widget_new_publication_content.dart';
import 'package:flutter/widgets.dart';

import 'new_publication_viewmodel.dart';

class NewPublicationView extends StandardBaseView<NewPublicationViewModel> {
  NewPublicationView({
    String? hubId,
  }) : super(NewPublicationViewModel(hubId),
    routeName: Routes.newPublicationView,
  );

  @override
  Widget getContent(BuildContext context) => WidgetNewPublicationContent();
}
