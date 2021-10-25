import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/edit_hub/edit_hub_view_content.dart';
import 'package:dairo/presentation/view/hub/edit_hub/edit_hub_viewmodel.dart';
import 'package:flutter/material.dart';

class EditHubView extends StandardBaseView<EditHubViewModel> {
  EditHubView(Hub hub)
      : super(EditHubViewModel(hub), routeName: Routes.editHubView);

  @override
  Widget getContent(BuildContext context) => EditHubViewContent();
}
