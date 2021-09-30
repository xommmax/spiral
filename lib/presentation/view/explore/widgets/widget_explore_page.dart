import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/explore/explore_viewmodel.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_items.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetExplorePage extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, ExploreViewModel viewModel) {
    return ListView(
      children: [
        Text(
          "Popular hubs",
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        Container(
          height: 100,
          color: AppColors.gray,
        ),
        Text(
          "Popular publications",
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        WidgetExplorePublicationsGrid(),
      ],
    );
  }
}

class WidgetExplorePublicationsGrid extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(context, viewModel) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: viewModel.viewData.explorePublications
          .map((publication) => WidgetExplorePublication(
              publication: publication,
              onPublicationClicked: viewModel.onPublicationClicked))
          .toList(),
    );
  }
}

class WidgetExploreHubCarousel extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, ExploreViewModel viewModel) {
    List<Widget> items = [];
    for (int i = 0; i < viewModel.viewData.exploreHubs.length; i++) {
      Hub hub = viewModel.viewData.exploreHubs[i];
      List<String> mediaUrls = [];
      if (i < viewModel.viewData.exploreHubMediaPreviews.length)
        mediaUrls = viewModel.viewData.exploreHubMediaPreviews[i];
      items.add(WidgetExploreHub(
          hub: hub,
          mediaUrls: mediaUrls,
          onHubClicked: viewModel.onHubClicked));
    }
    double width = MediaQuery.of(context).size.width;
    double cardWidth = width * 0.7;
    double cardHeaderImageHeight =
        cardWidth / Dimens.hubPictureRatioX * Dimens.hubPictureRatioY;
    double description = 46;
    double cardMediaPreviewHeight = cardWidth / 3;
    double cardBottomPadding = 8;
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: cardHeaderImageHeight + description + cardMediaPreviewHeight + cardBottomPadding,
        viewportFraction: 0.7,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        disableCenter: true,
      ),
    );
  }
}
