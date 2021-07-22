import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  TextEditingController searchTextController = new TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
// @override
  // Stream get stream => throw UnimplementedError();
  //
  // @override
  // void onData(T data) {
  //
  // }

}
