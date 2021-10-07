import 'package:dairo/presentation/view/hub/discussion/hub_discussion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HubDiscussionViewContent extends ViewModelWidget<HubDiscussionViewModel> {
  @override
  Widget build(BuildContext context, HubDiscussionViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Text("Test"),
      ),
    );
  }
}
