import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/publication/preview/publication_preview_widget.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_view_content.dart';
import 'package:flutter/widgets.dart';

class PublicationView extends StandardBaseView<PublicationViewModel> {
  final bool isPreview;

  PublicationView(
    String publicationId, {
    this.isPreview = false,
  }) : super(
          PublicationViewModel(
              publicationId: publicationId, isPreview: isPreview),
          routeName: Routes.publicationView,
        );

  @override
  Widget getContent(BuildContext context) {
    if (isPreview) {
      return PublicationPreviewWidget();
    } else {
      return PublicationViewContent();
    }
  }
}
