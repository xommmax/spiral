import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/input_decoration.dart';
import 'package:dairo/presentation/view/settings/support/support_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetSupportContent extends ViewModelWidget<SupportViewModel> {
  @override
  Widget build(BuildContext context, SupportViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.support,
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
                          controller: viewModel.viewData.subjectController,
                          maxLength: 40,
                          maxLines: 1,
                          decoration: CustomInputDecoration(Strings.subject),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        TextFormField(
                          controller: viewModel.viewData.descriptionController,
                          maxLength: 350,
                          maxLines: 8,
                          minLines: 1,
                          decoration:
                              CustomInputDecoration(Strings.description),
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
