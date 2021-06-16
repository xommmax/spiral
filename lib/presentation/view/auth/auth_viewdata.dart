import 'package:flutter/widgets.dart';

class AuthViewData {
  final TextEditingController phoneNumberController = TextEditingController();

  bool isCodeSent = false;
  String? verificationId;
  String? phoneCode;
}
