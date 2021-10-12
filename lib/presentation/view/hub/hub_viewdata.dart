import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class HubViewData {
  List<Publication> publications = [];
  List<quill.QuillController> textControllers = [];
  Hub? hub;
  User? user;

  bool isDataReady() => hub != null && user != null;
}
