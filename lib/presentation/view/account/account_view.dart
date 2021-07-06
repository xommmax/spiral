import 'package:dairo/presentation/view/account/account_viewmodel.dart';
import 'package:dairo/presentation/view/account/widgets/widget_account_view_content.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/material.dart';

class AccountView extends StandardBaseView<AccountViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetAccountViewContent();

  @override
  getViewModel() => AccountViewModel();
}
