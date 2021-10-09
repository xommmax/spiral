import 'package:flutter/cupertino.dart';

class AccountDetailsViewData {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? photoUrl;
  bool isDataChanged = false;
}