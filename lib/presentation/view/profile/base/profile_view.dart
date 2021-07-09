import 'package:dairo/presentation/view/profile/base/profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_view_content.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StandardBaseView<ProfileViewModel> {
  @override
  Widget getContent(BuildContext context) => WidgetProfileViewContent();

  @override
  getViewModel() => ProfileViewModel();
}
