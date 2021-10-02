import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/new_publication/new_pub_hub_selection/new_pub_hub_selection_viewmodel.dart';
import 'package:dairo/presentation/view/new_publication/new_pub_hub_selection/widgets/new_pub_hub_selection_view_content.dart';
import 'package:flutter/widgets.dart';

class NewPubHubSelectionView
    extends StandardBaseView<NewPubHubSelectionViewModel> {
  NewPubHubSelectionView()
      : super(NewPubHubSelectionViewModel(),
            routeName: Routes.newPubHubSelectionView);

  @override
  Widget getContent(BuildContext context) => NewPubHubSelectionViewContent();
}
