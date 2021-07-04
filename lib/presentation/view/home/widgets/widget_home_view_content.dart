import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../home_viewmodel.dart';

class WidgetHomeViewContent extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Text("Home tab"),
          ),
        ),
      );
}
