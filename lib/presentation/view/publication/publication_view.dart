import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:dairo/presentation/view/publication/widgets/widget_publication_view_content.dart';
import 'package:flutter/widgets.dart';

class PublicationView extends StandardBaseView<PublicationViewModel> {
  PublicationView(
    String publicationId,
    String userId,
    String hubId,
  ) : super(
          PublicationViewModel(
            publicationId: publicationId,
            userId: userId,
            hubId: hubId,
          ),
          routeName: Routes.publicationView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetPublicationViewContent();
}
