import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/publication/preview/publication_preview_widget.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_view_content.dart';
import 'package:flutter/widgets.dart';

class PublicationView extends StandardBaseView<PublicationViewModel> {
  PublicationView(String publicationId)
      : super(
          PublicationViewModel(publicationId: publicationId, isPreview: false),
          routeName: Routes.publicationView,
        );

  PublicationView.preview(PublicationViewModel viewModel)
      : super(
          viewModel,
          routeName: Routes.publicationView,
          disposeViewModel: false,
          key: Key(viewModel.publicationId),
        );

  @override
  Widget getContent(BuildContext context) {
    if (viewModel.isPreview) {
      return PublicationPreviewWidget();
    } else {
      return PublicationViewContent();
    }
  }
}
