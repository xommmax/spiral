import 'dart:convert';

import 'package:dairo/domain/model/publication/publication.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

quill.DefaultStyles getPublicationTextStyle(BuildContext context) {
  var defaultStyles = quill.DefaultStyles.getInstance(context);

  quill.DefaultTextBlockStyle newParagraphStyle = quill.DefaultTextBlockStyle(
    defaultStyles.paragraph!.style.copyWith(fontSize: 15),
    defaultStyles.paragraph!.verticalSpacing,
    defaultStyles.paragraph!.lineSpacing,
    defaultStyles.paragraph!.decoration,
  );

  quill.DefaultTextBlockStyle newH1Style = quill.DefaultTextBlockStyle(
    defaultStyles.h1!.style.copyWith(fontSize: 30, fontWeight: FontWeight.w400),
    defaultStyles.h1!.verticalSpacing,
    defaultStyles.h1!.lineSpacing,
    defaultStyles.h1!.decoration,
  );

  quill.DefaultTextBlockStyle newH2Style = quill.DefaultTextBlockStyle(
    defaultStyles.h2!.style.copyWith(fontSize: 24),
    defaultStyles.h2!.verticalSpacing,
    defaultStyles.h2!.lineSpacing,
    defaultStyles.h2!.decoration,
  );

  quill.DefaultTextBlockStyle newH3Style = quill.DefaultTextBlockStyle(
    defaultStyles.h3!.style.copyWith(fontSize: 19),
    defaultStyles.h3!.verticalSpacing,
    defaultStyles.h3!.lineSpacing,
    defaultStyles.h3!.decoration,
  );

  quill.DefaultTextBlockStyle newPlaceholderStyle = quill.DefaultTextBlockStyle(
    defaultStyles.placeHolder!.style.copyWith(fontSize: 15),
    defaultStyles.placeHolder!.verticalSpacing,
    defaultStyles.placeHolder!.lineSpacing,
    defaultStyles.placeHolder!.decoration,
  );

  return quill.DefaultStyles(
    paragraph: newParagraphStyle,
    h1: newH1Style,
    h2: newH2Style,
    h3: newH3Style,
    placeHolder: newPlaceholderStyle,
  );
}
