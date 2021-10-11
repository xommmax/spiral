import 'dart:convert';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/data/api/repository/firebase_storage_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/comment.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PublicationViewModel extends MultipleStreamViewModel {
  static const PUBLICATION_STREAM_KEY = 'PUBLICATION_STREAM_KEY';
  static const COMMENTS_STREAM_KEY = 'COMMENTS_STREAM_KEY';
  static const USER_STREAM_KEY = 'USER_STREAM_KEY';
  static const HUB_STREAM_KEY = 'HUB_STREAM_KEY';

  final String publicationId;
  final String userId;
  final String hubId;
  quill.QuillController? textController;

  PublicationViewModel({
    required this.publicationId,
    required this.userId,
    required this.hubId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final TextEditingController commentsTextController = TextEditingController();
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  final NavigationService navigationService = locator<NavigationService>();
  final SupportRepository _supportRepository = locator<SupportRepository>();
  final FirebaseStorageRepository _firebaseStorageRepository =
      locator<FirebaseStorageRepository>();

  Publication? publication;
  User? user;
  Hub? hub;
  List<Comment>? comments;
  Comment? commentToReply;

  @override
  Map<String, StreamData> get streamsMap => {
        PUBLICATION_STREAM_KEY: StreamData<Publication?>(
          publicationStream(),
          onData: _onPublicationRetrieved,
        ),
        COMMENTS_STREAM_KEY: StreamData<List<Comment>?>(
          commentsStream(),
          onData: _onCommentsRetrieved,
        ),
        USER_STREAM_KEY: StreamData<User?>(
          userStream(),
          onData: _onUserRetrieved,
        ),
        HUB_STREAM_KEY: StreamData<Hub?>(
          hubStream(),
          onData: _onHubRetrieved,
        ),
      };

  Stream<User?> userStream() => _userRepository.getUser(userId);

  Stream<Hub?> hubStream() => _hubRepository.getHub(hubId);

  void _onUserRetrieved(User? user) => this.user = user;

  void _onHubRetrieved(Hub? hub) => this.hub = hub;

  Stream<Publication?> publicationStream() =>
      _publicationRepository.getPublication(publicationId);

  Stream<List<Comment>?> commentsStream() =>
      _publicationRepository.getComments(publicationId);

  void _onPublicationRetrieved(Publication? publication) {
    List textJson = [];
    try {
      if (publication != null &&
          publication.text != null &&
          publication.text!.isNotEmpty) {
        textJson = jsonDecode(publication.text!);
        textController = quill.QuillController(
            document: quill.Document.fromJson(textJson),
            selection: TextSelection.collapsed(offset: 0));
      } else {
        textController = quill.QuillController.basic();
      }
    } catch (e) {
      textController = quill.QuillController.basic();
    }
    this.publication = publication;
  }

  void _onCommentsRetrieved(List<Comment>? comments) =>
      this.comments = comments;

  @override
  void onError(String key, error) {
    print('Error: $error on key: $key');
    AppSnackBar.showSnackBarError(Strings.unableToGetPublication);
  }

  void onSendCommentClicked() {
    if (commentsTextController.text.isEmpty) return;
    _publicationRepository
        .sendComment(
      publicationId: publicationId,
      text: commentsTextController.text,
      createAt: DateTime.now().millisecondsSinceEpoch,
      parentCommentId: commentToReply?.id,
    )
        .then(
      (_) {
        commentsTextController.clear();
        setCommentToReply(null);
      },
    );
  }

  bool isDataReady() => publication != null;

  void setCommentToReply(Comment? comment) {
    commentToReply = comment;
    notifyListeners();
  }

  void onUserClicked() {
    if (user != null) {
      navigationService.navigateTo(Routes.userProfileView,
          arguments: UserProfileViewArguments(userId: user!.id));
    }
  }

  void onHubClicked() {
    if (hub != null && user != null) {
      navigationService.navigateTo(Routes.hubView,
          arguments: HubViewArguments(hubId: hub!.id, userId: user!.id));
    }
  }

  void onReport() async {
    _supportRepository.reportPublication(
        publicationId: publicationId, reason: "TODO");
    AppDialog.showInformDialog(
        title: Strings.reported, description: Strings.reportedPublicationDesc);
  }

  String getAttachedFileName() =>
      _firebaseStorageRepository.getFileName(publication!.attachedFileUrl!);

  void downloadAttachedFile() {
    AppSnackBar.showSnackBarError("Missing functionallity");
  }
}
