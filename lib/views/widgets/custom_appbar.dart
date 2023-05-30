import 'package:flutter/material.dart';
import 'package:waffarha_flutter_challenge/utils/color_manager.dart';
import 'package:waffarha_flutter_challenge/utils/font_manager.dart';
import 'package:waffarha_flutter_challenge/utils/values_manager.dart';
import 'package:waffarha_flutter_challenge/views/widgets/custom_text.dart';

/// A custom app bar widget that can be used throughout the app.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title of the app bar.
  final String title;

  /// The list of actions to display in the app bar.
  final List<Widget>? actions;

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// The color of the icons in the app bar.
  final Color? iconColor;

  /// The widget to display on the left side of the app bar.
  final Widget? leadingWidget;

  /// The text color of the app bar title.
  final Color? textColor;

  const CustomAppBar({
    required this.title,
    this.actions,
    this.backgroundColor,
    this.iconColor,
    this.leadingWidget,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppSize.s28),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.white,
      title: CustomText(
        text: title,
        textColor: ColorManager.whiteColor,
        fontSize: FontSize.s20,
        isBold: true,
      ),
      centerTitle: true,
      actions: actions,
      leading: leadingWidget,
      iconTheme: IconThemeData(
        color: iconColor ?? Colors.white,
      ),
    );
  }

  /// Returns the preferred size of the app bar.
  ///
  /// This is necessary to implement the [PreferredSizeWidget] interface.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
