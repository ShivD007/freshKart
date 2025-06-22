import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      title: title,
      actions: actions,
      leading: leading,
    );
  }
}
