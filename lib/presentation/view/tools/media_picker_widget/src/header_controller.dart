import 'package:flutter/material.dart';

import 'media.dart';

class HeaderController {
  HeaderController();

  ValueChanged<List<Media>>? updateSelection;
  VoidCallback? closeAlbumDrawer;
}
