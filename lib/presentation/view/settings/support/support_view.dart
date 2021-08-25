import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/support/support_viewmodel.dart';
import 'package:dairo/presentation/view/settings/support/widgets/widget_support_content.dart';
import 'package:flutter/widgets.dart';


class SupportView extends StandardBaseView<SupportViewModel> {
  SupportView()
      : super(
          SupportViewModel(),
        );

  @override
  Widget getContent(BuildContext context) => WidgetSupportContent();
}
