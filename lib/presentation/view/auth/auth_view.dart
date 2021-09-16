import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_auth_view_content.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/widgets.dart';

import 'auth_viewmodel.dart';

class AuthView extends StandardBaseView<AuthViewModel> {
  AuthView()
      : super(
          AuthViewModel(),
          routeName: Routes.authView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetAuthViewContent();
}
