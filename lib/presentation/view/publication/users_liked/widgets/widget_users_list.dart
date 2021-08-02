import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/publication/users_liked/users_liked_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetUsersList extends ViewModelWidget<UsersLikedViewModel> {
  @override
  Widget build(BuildContext context, UsersLikedViewModel viewModel) =>
      viewModel.dataReady
          ? ListView.separated(
              itemBuilder: (context, index) =>
                  _WidgetUser(viewModel.data![index]),
              separatorBuilder: (context, index) => Divider(
                height: 10,
              ),
              itemCount: viewModel.data!.length,
            )
          : ProgressBar(
              alignment: ProgressBarAlignment.Center,
            );
}

class _WidgetUser extends StatelessWidget {
  final User _user;

  const _WidgetUser(this._user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        leading: _user.photoURL != null
            ? CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: _user.photoURL!,
                ),
              )
            : Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ),
        title: Text(
          _user.displayName ??
              _user.email ??
              _user.phoneNumber ??
              Strings.unknown,
          style: TextStyles.robotoBlack14,
        ),
      );
}
