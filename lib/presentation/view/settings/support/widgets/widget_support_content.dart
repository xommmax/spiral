import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
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
            style: TextStyles.white22Bold,
          ),
          actions: [
            !viewModel.isBusy
                ? Center(
                    child: IconButton(
                      onPressed: viewModel.onSubmitMessageClicked,
                      icon: Icon(
                        Icons.done,
                        color: AppColors.white,
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
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.subject,
                            hintStyle: TextStyle(color: AppColors.gray),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        TextFormField(
                          controller: viewModel.viewData.descriptionController,
                          maxLength: 350,
                          maxLines: 9,
                          minLines: 9,
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.description,
                            hintStyle: TextStyle(color: AppColors.gray),
                          ),
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
