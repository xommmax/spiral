import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:flutter/widgets.dart';

class WidgetRouteChangesTracker extends StatefulWidget {
  final AnalyticsRepository analyticsRepository =
      locator<AnalyticsRepository>();
  final String routeName;
  final Widget child;

  WidgetRouteChangesTracker({
    required this.routeName,
    required this.child,
  });

  @override
  _WidgetRouteChangesTrackerState createState() =>
      _WidgetRouteChangesTrackerState();
}

class _WidgetRouteChangesTrackerState extends State<WidgetRouteChangesTracker>
    with RouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.analyticsRepository
        .getObserver()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
    super.didPopNext();
  }

  @override
  void dispose() {
    widget.analyticsRepository.getObserver().unsubscribe(this);
    super.dispose();
  }

  void _sendCurrentTabToAnalytics() =>
      widget.analyticsRepository.setCurrentScreen(
        screenName: widget.routeName,
      );
}
