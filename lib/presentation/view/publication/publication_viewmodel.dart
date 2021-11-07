import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
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
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicationViewModel extends MultipleStreamViewModel {
  static const publicationStreamKey = 'PUBLICATION_STREAM_KEY';
  static const commentsStreamKey = 'COMMENTS_STREAM_KEY';
  static const maxPreviewTextHeight = 300.0;

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  final NavigationService navigationService = locator<NavigationService>();
  final SupportRepository _supportRepository = locator<SupportRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController commentsTextController = TextEditingController();

  final String publicationId;
  final bool isPreview;

  final GlobalKey previewTextStickyKey = GlobalKey();

  quill.QuillController? textController;
  double? previewTextHeight;
  StreamSubscription? hubStreamSubscription;
  StreamSubscription? userStreamSubscription;

  Publication? publication;
  User? user;
  Hub? hub;
  List<Comment>? comments;
  Comment? commentToReply;

  PublicationViewModel({
    required this.publicationId,
    required this.isPreview,
  });

  @override
  Map<String, StreamData> get streamsMap => {
        publicationStreamKey: StreamData<Publication?>(
          _publicationRepository.getPublication(publicationId),
          onData: _onPublicationReceived,
        ),
        commentsStreamKey: StreamData<List<Comment>?>(
          _publicationRepository.getComments(publicationId),
          onData: (comments) => this.comments = comments,
        ),
      };

  @override
  void onError(String key, error) =>
      AppSnackBar.showSnackBarError(Strings.errorLoadingPublication);

  void _onPublicationReceived(Publication? publication) {
    if (publication == null) return;
    this.publication = publication;
    textController = initTextController(publication);
    if (hubStreamSubscription == null) {
      hubStreamSubscription =
          _hubRepository.getHub(publication.hubId).listen((hub) {
        this.hub = hub;
        notifyListeners();
      });
    }
    if (userStreamSubscription == null) {
      userStreamSubscription =
          _userRepository.getUser(publication.userId).listen((user) {
        this.user = user;
        notifyListeners();
      });
    }
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

  void onReport() {
    _supportRepository.reportPublication(
        publicationId: publicationId, reason: "TODO");
    AppDialog.showInformDialog(
        title: Strings.reported, description: Strings.reportedPublicationDesc);
  }

  void onDelete() {
    _publicationRepository.deletePublication(publicationId: publicationId);
    if (!isPreview) {
      navigationService.back();
    }
  }

  void onLinkClicked() {
    launch(publication!.link!).catchError(
        (e) => AppSnackBar.showSnackBarError(Strings.errorCouldNotLaunchUrl));
  }

  void onFileClicked() async {
    var file = await DefaultCacheManager()
        .getSingleFile(publication!.attachedFileUrl!);
    await OpenFile.open(file.path);
  }

  void onPublicationLikeClicked() => _publicationRepository.sendLike(
        publicationId: publicationId,
        isLiked: !(publication!.isLiked),
      );

  void onUsersLikedScreenClicked() async {
    List<String> userIds =
        await _publicationRepository.getUsersLiked(publicationId);
    return _navigationService.navigateTo(
      Routes.followersView,
      arguments: FollowersViewArguments(
        userIds: userIds,
        type: FollowersType.Likes,
      ),
    );
  }

  void onPublicationPreviewClicked() {
    if (publication == null) return;
    _navigationService.navigateTo(
      Routes.publicationView,
      arguments: PublicationViewArguments(publicationId: publicationId),
    );
  }

  bool isCurrentUserPublication() => _userRepository.isCurrentUser(user!.id);

  bool isCurrentUserAdmin() =>
      _userRepository.isCurrentUser("sERzuCv3zogdEcwPbEUhqhh33HC2") ||
      _userRepository.isCurrentUser("UvWoMSYF3OeoFEBb0bC0zpPLdaK2");

  void calcPreviewTextHeight() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      var tempHeight = previewTextStickyKey.currentContext?.size?.height;
      if (previewTextHeight != tempHeight && tempHeight != null) {
        previewTextHeight = tempHeight;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    textController?.dispose();
    commentsTextController.dispose();
    hubStreamSubscription?.cancel();
    userStreamSubscription?.cancel();
    super.dispose();
  }
}
