import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/messaging/messaging_view_content.dart';
import 'package:dairo/presentation/view/messaging/messaging_viewmodel.dart';
import 'package:flutter/widgets.dart';

class MessagingView extends StandardBaseView<MessagingViewModel> {
  @override
  Widget getContent(BuildContext context) => MessagingViewContent();

  MessagingView() : super(MessagingViewModel());
}
