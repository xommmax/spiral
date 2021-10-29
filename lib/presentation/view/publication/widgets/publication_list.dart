import 'package:dairo/presentation/view/publication/publication_view.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:flutter/material.dart';

class PublicationListView extends StatefulWidget {
  final List<String> publicationIds;

  PublicationListView(this.publicationIds);

  @override
  State<StatefulWidget> createState() => PublicationListViewState();
}

class PublicationListViewState extends State<PublicationListView> {
  final Map<String, PublicationViewModel> viewModels = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final publicationId = widget.publicationIds[index];
            return PublicationView.preview(_getViewModel(publicationId));
          },
          childCount: widget.publicationIds.length,
        ),
      );

  PublicationViewModel _getViewModel(String publicationId) {
    if (!viewModels.containsKey(publicationId)) {
      viewModels[publicationId] = PublicationViewModel(
        publicationId: publicationId,
        isPreview: true,
      );
    }
    return viewModels[publicationId]!;
  }

  @override
  void dispose() {
    viewModels.values.forEach((viewModel) => viewModel.dispose());
    super.dispose();
  }
}
