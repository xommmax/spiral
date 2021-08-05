import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/search/search_viewmodel.dart';
import 'package:dairo/presentation/view/search/widgets/widget_search_view_content.dart';
import 'package:flutter/material.dart';

class SearchView extends StandardBaseView<SearchViewModel> {
  SearchView() : super(SearchViewModel());

  @override
  Widget getContent(BuildContext context) => WidgetSearchViewContent();
}
