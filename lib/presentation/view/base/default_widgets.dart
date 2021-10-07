import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/widgets.dart';

class DefaultHubImage extends StatelessWidget {
  final int radius;

  DefaultHubImage({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DefaultProfileImage extends StatelessWidget {
  final double radius;

  DefaultProfileImage({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
