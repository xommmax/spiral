import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ExploreViewData {
  List<Publication> explorePublications = [];
  List<quill.QuillController> textControllers = [];
  List<Hub> exploreHubs = [];
  List<List<String>> exploreHubMediaPreviews = [];
}
