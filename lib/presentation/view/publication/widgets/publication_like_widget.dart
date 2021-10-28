import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class PublicationLikeWidget extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    final likesCount = viewModel.publication!.likesCount;
    return Row(
      children: [
        IconButton(
          onPressed: viewModel.onPublicationLikeClicked,
          icon: Icon(
            viewModel.publication!.isLiked
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: AppColors.white,
          ),
        ),
        if (likesCount != 0)
          InkWell(
            onTap: () => viewModel.onUsersLikedScreenClicked(),
            child: Text(
              likesCount.toString() + ((likesCount == 1) ? ' like' : ' likes'),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
