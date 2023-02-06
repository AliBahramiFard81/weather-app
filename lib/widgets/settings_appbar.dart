import 'package:flutter/material.dart';

class SettingsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext context;
  const SettingsAppBar({
    super.key,
    required this.context,
  });

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  double buttonHeight = 50;
  double buttonWidth = 50;

  @override
  Widget build(context) {
    return AppBar(
      title: const Text(
        "Settings",
        style: TextStyle(fontFamily: 'RussoOne'),
      ),
      titleSpacing: 0,
      leadingWidth: 100,
      backgroundColor: const Color.fromRGBO(26, 28, 30, 1),
      elevation: 0,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTapDown: (details) {
            setState(() {
              buttonHeight = 45;
              buttonWidth = 45;
            });
          },
          onTapCancel: () {
            setState(() {
              buttonHeight = 50;
              buttonWidth = 50;
            });
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(left: 20),
            width: buttonWidth,
            height: buttonHeight,
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(32, 35, 41, 1),
            ),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(widget.context, true);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color.fromRGBO(174, 176, 178, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
