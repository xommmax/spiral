import 'dart:io';

import 'package:dairo/domain/model/publication/publication.dart';

class NewPublicationViewData {
  final Publication publication = Publication();
  List<File> mediaFiles = [];
}
