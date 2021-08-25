import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/strings.dart';

class SettingsViewData {
  User? user;

  final settingsItems = [
    Strings.accountDetails,
    Strings.support,
    Strings.termsOfUsage,
  ];
}
