import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class HomeViewData {
  User? user;
  List<Publication?> publications = [];
  List<quill.QuillController> textControllers = [];
  Map<String, User?> users = {};
  Map<String, Hub?> hubs = {};
}
