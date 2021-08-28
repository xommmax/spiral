import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';

class HomeViewData {
  User? user;
  List<Publication?> publications = [];
  Map<String, User?> users = {};
  Map<String, Hub?> hubs = {};
}
