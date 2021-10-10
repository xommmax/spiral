import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/input_decoration.dart';
import 'package:dairo/presentation/view/settings/contact/suggestion/suggestion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class SuggestionViewContent extends ViewModelWidget<SuggestionViewModel> {
  @override
  Widget build(BuildContext context, SuggestionViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.suggestion,
            style: TextStyles.toolbarTitle,
          ),
          actions: [
            !viewModel.isBusy
                ? Center(
                    child: IconButton(
                      onPressed: viewModel.onSubmitMessageClicked,
                      icon: Icon(
                        Icons.done,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: viewModel.suggestionController,
                          maxLength: 350,
                          maxLines: 8,
                          minLines: 1,
                          style: TextStyle(color: AppColors.white),
                          decoration: CustomInputDecoration(Strings.yourIdea),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
