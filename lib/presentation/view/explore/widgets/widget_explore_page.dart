import 'package:carousel_slider/carousel_slider.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/explore/explore_viewmodel.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_items.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExplorePopularHubCarousel extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, ExploreViewModel viewModel) {
    List<Widget> items = [];
    for (int i = 0; i < viewModel.viewData.popularHubs.length; i++) {
      Hub hub = viewModel.viewData.popularHubs[i];
      List<String> mediaUrls = [];
      if (i < viewModel.viewData.popularHubsMediaPreviews.length)
        mediaUrls = viewModel.viewData.popularHubsMediaPreviews[i];
      items.add(WidgetExploreHub(
          hub: hub,
          mediaUrls: mediaUrls,
          onHubClicked: viewModel.onHubClicked));
    }
    double width = MediaQuery.of(context).size.width;
    final viewportFraction = 0.7;
    final cardMargin = 16;
    double cardWidth = width * viewportFraction - cardMargin;
    double cardHeaderImageHeight = cardWidth / Dimens.hubPictureRatio;
    double description = 50;
    double cardMediaPreviewHeight = cardWidth / 3;
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: cardHeaderImageHeight + description + cardMediaPreviewHeight,
        viewportFraction: viewportFraction,
        initialPage: 1,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        disableCenter: true,
      ),
      carouselController: viewModel.popularHubsCarouselController,
    );
  }
}

class ExplorePopularPublicationsGrid extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(context, viewModel) {
    List<Widget> children = [];
    for (int i = 0; i < viewModel.viewData.popularPublications.length; i++) {
      children.add(WidgetExplorePublication(
        publication: viewModel.viewData.popularPublications[i],
        textController:
            viewModel.viewData.popularPublicationsTextControllers[i],
        onPublicationClicked: viewModel.onPublicationClicked,
      ));
    }
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: children,
    );
  }
}

class ExploreRecentPublicationsGrid extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(context, viewModel) {
    List<Widget> children = [];
    for (int i = 0; i < viewModel.viewData.recentPublications.length; i++) {
      children.add(WidgetExplorePublication(
        publication: viewModel.viewData.recentPublications[i],
        textController: viewModel.viewData.recentPublicationsTextControllers[i],
        onPublicationClicked: viewModel.onPublicationClicked,
      ));
    }
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: children,
    );
  }
}
