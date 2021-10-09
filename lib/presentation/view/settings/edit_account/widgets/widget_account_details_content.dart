import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/edit_account/account_details_viewmodel.dart';
import 'package:dairo/presentation/view/settings/edit_account/widgets/widget_account_details_avatar.dart';
import 'package:dairo/presentation/view/settings/edit_account/widgets/widget_account_details_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetAccountDetailsContent
    extends ViewModelWidget<AccountDetailsViewModel> {
  @override
  Widget build(BuildContext context, AccountDetailsViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.accountDetails,
            style: TextStyles.toolbarTitle,
          ),
          actions: [
            viewModel.viewData.isDataChanged && !viewModel.isBusy
                ? Center(
                    child: IconButton(
                      onPressed: viewModel.onDoneClicked,
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
          onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: WidgetAccountDetailsAvatar(),
                        ),
                        SizedBox(height: 16),
                        WidgetAccountDetailsInputFields(),
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
