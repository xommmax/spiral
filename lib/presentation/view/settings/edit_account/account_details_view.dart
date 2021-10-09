import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/edit_account/account_details_viewmodel.dart';
import 'package:dairo/presentation/view/settings/edit_account/widgets/widget_account_details_content.dart';
import 'package:flutter/widgets.dart';

class AccountDetailsView extends StandardBaseView<AccountDetailsViewModel> {
  AccountDetailsView()
      : super(
          AccountDetailsViewModel(),
          routeName: Routes.accountDetailsView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetAccountDetailsContent();
}
