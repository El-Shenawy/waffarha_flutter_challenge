import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:waffarha_flutter_challenge/utils/color_manager.dart';
import 'package:waffarha_flutter_challenge/utils/values_manager.dart';


/// A custom loader widget that displays a bouncing grid animation.
class CustomLoader extends StatelessWidget {
  /// The size of the loader.
  final double? size;

  const CustomLoader({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingBouncingGrid.circle(
      size: size ?? AppSize.s40,
      backgroundColor: ColorManager.mainColor,
    );
  }
}