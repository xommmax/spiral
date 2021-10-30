import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ExploreViewData {
  List<Publication> popularPublications = [];
  List<quill.QuillController> popularPublicationsTextControllers = [];
  List<Publication> recentPublications = [];
  List<quill.QuillController> recentPublicationsTextControllers = [];
  List<Hub> popularHubs = [];
  List<List<String>> popularHubsMediaPreviews = [];
}
