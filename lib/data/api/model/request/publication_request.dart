import 'dart:io';

import 'package:dairo/domain/model/publication/publication.dart';

class PublicationRequest {
  final String? text;
  final List<File> mediaFiles;

  const PublicationRequest({
    this.text,
    required this.mediaFiles,
  });

  factory PublicationRequest.fromDomain(Publication publication) =>
      PublicationRequest(
        text: publication.inputText,
        mediaFiles:
            publication.mediaFiles.map((media) => File(media.path)).toList(),
      );
}
