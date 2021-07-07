import 'package:dairo/domain/model/publication/publication.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publication_request.g.dart';

@JsonSerializable()
class PublicationRequest {
  final String? hubId;
  final String? text;
  List<String>? downloadedUrls;

  PublicationRequest({
    required this.hubId,
    this.text,
  });

  factory PublicationRequest.fromDomain(Publication publication) =>
      PublicationRequest(
        hubId: publication.hubId,
        text: publication.inputText,
      );

  Map<String, dynamic> toJson() => _$PublicationRequestToJson(this);
}
