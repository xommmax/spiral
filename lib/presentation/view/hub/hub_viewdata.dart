import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';

class HubViewData {
  List<Publication> publications = [];
  Hub? hub;
  User? user;

  bool isDataReady() => hub != null && user != null;
}
