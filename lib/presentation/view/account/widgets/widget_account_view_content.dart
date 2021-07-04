import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../account_viewmodel.dart';

class WidgetAccountViewContent extends ViewModelWidget<AccountViewModel> {
  @override
  Widget build(BuildContext context, AccountViewModel viewModel) => Scaffold(
        body: SafeArea(child: Container()),
      );
}
