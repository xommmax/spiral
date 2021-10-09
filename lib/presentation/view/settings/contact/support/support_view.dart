import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/contact/support/support_viewmodel.dart';
import 'package:dairo/presentation/view/settings/contact/support/widget_support_content.dart';
import 'package:flutter/widgets.dart';

class SupportView extends StandardBaseView<SupportViewModel> {
  SupportView()
      : super(
          SupportViewModel(),
          routeName: Routes.supportView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetSupportContent();
}
