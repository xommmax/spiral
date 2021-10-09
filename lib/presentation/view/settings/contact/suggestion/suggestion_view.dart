import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/settings/contact/suggestion/suggestion_view_content.dart';
import 'package:dairo/presentation/view/settings/contact/suggestion/suggestion_viewmodel.dart';
import 'package:flutter/widgets.dart';

class SuggestionView extends StandardBaseView<SuggestionViewModel> {
  @override
  Widget getContent(BuildContext context) => SuggestionViewContent();

  SuggestionView()
      : super(SuggestionViewModel(), routeName: Routes.suggestionView);
}
