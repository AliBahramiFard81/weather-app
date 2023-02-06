import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/settings.dart';

class HomePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String location;
  final String date;
  final Function() refresh;
  const HomePageAppBar({
    super.key,
    required this.location,
    required this.date,
    required this.refresh,
  });

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  double buttonHeight = 50;
  double buttonWidth = 50;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: const Color.fromRGBO(26, 28, 30, 1),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(26, 28, 30, 1)),
      title: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.location,
              style: const TextStyle(fontFamily: 'RussoOne'),
            ),
            Text(
              widget.date,
              style: const TextStyle(
                fontFamily: 'ChakraPetch',
                fontSize: 15,
                color: Color.fromRGBO(174, 176, 178, 1),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
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
              width: buttonWidth,
              height: buttonHeight,
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(32, 35, 41, 1),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context)
                      .push(Settings())
                      .then((value) => value! ? widget.refresh() : null);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Color.fromRGBO(174, 176, 178, 1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
