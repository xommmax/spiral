import 'dart:convert';

import 'package:dairo/domain/model/publication/publication.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

quill.QuillController initTextController(Publication? publication) {
  quill.QuillController textController;
  List textJson = [];
  try {
    if (publication != null &&
        publication.text != null &&
        publication.text!.isNotEmpty) {
      textJson = jsonDecode(publication.text!);
      textController = quill.QuillController(
          document: quill.Document.fromJson(textJson),
          selection: TextSelection.collapsed(offset: 0));
    } else {
      textController = quill.QuillController.basic();
    }
  } catch (e) {
    textController = quill.QuillController.basic();
  }
  return textController;
}
