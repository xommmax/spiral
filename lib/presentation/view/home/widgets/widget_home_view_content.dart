import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../home_viewmodel.dart';

class WidgetHomeViewContent extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.home),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Home tab"),
      ),
    );
  }
}
