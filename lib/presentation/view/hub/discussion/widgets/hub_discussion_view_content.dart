import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/discussion.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/hub/discussion/hub_discussion_viewmodel.dart';
import 'package:dairo/presentation/view/tools/flutter_firebase_chat_core/firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:stacked/stacked.dart';

class HubDiscussionViewContent extends ViewModelWidget<HubDiscussionViewModel> {
  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
    HubDiscussionViewModel viewModel,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);
    FirebaseChatCore.instance
        .updateMessage(updatedMessage, viewModel.discussion!.id);
  }

  void _handleSendPressed(
    types.PartialText message,
    HubDiscussionViewModel viewModel,
  ) {
    FirebaseChatCore.instance.sendMessage(
      message,
      viewModel.discussion!.id,
    );
  }

  @override
  Widget build(BuildContext context, HubDiscussionViewModel viewModel) {
    if (viewModel.discussion == null) return SizedBox();
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              viewModel.discussion!.imageUrl!,
            ),
          ),
          title: Text(
            viewModel.discussion!.name!,
            style: TextStyles.toolbarTitle,
          ),
        ),
      ),
      body: StreamBuilder<HubDiscussion>(
        initialData: viewModel.discussion!,
        stream: FirebaseChatCore.instance.discussion(viewModel.discussion!.id),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              return SafeArea(
                bottom: false,
                child: Chat(
                  onMessageLongPress: (m) => showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          OptionsBottomSheet(() => viewModel.onReport(m))),
                  theme: DefaultChatTheme(
                      backgroundColor: AppColors.darkAccentColor),
                  showUserAvatars: true,
                  showUserNames: true,
                  messages: snapshot.data ?? [],
                  onPreviewDataFetched: (m, d) =>
                      _handlePreviewDataFetched(m, d, viewModel),
                  onSendPressed: (t) => _handleSendPressed(t, viewModel),
                  user: types.User(
                    id: FirebaseAuth.instance.currentUser?.uid ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
