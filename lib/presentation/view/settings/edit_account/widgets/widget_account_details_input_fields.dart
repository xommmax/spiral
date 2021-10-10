import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/input_decoration.dart';
import 'package:dairo/presentation/view/settings/edit_account/account_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetAccountDetailsInputFields
    extends ViewModelWidget<AccountDetailsViewModel> {
  @override
  Widget build(BuildContext context, AccountDetailsViewModel viewModel) =>
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
          ),
          TextFormField(
            controller: viewModel.viewData.nameController,
            onChanged: viewModel.onNameChanged,
            autofocus: false,
            maxLines: 1,
            style: TextStyle(color: AppColors.white),
            decoration: CustomInputDecoration(Strings.name),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          TextFormField(
            controller: viewModel.viewData.usernameController,
            onChanged: viewModel.onUsernameChanged,
            autofocus: false,
            maxLines: 1,
            style: TextStyle(color: AppColors.white),
            decoration: CustomInputDecoration(Strings.username),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          TextFormField(
            controller: viewModel.viewData.descriptionController,
            onChanged: viewModel.onDescriptionChanged,
            autofocus: false,
            maxLength: 150,
            maxLines: 4,
            minLines: 1,
            style: TextStyle(color: AppColors.white),
            decoration: CustomInputDecoration(Strings.bio),
          ),
        ],
      );
}
