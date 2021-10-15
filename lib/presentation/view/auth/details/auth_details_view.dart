import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/auth/details/auth_details_view_content.dart';
import 'package:dairo/presentation/view/auth/details/auth_details_viewmodel.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/widgets.dart';

class AuthDetailsView extends StandardBaseView<AuthDetailsViewModel> {
  AuthDetailsView()
      : super(AuthDetailsViewModel(), routeName: Routes.authDetailsView);

  @override
  Widget getContent(BuildContext context) => AuthDetailsViewContent();
}
