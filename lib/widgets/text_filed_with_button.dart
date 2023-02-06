import 'package:flutter/material.dart';

class TextFiledWithButton extends StatefulWidget {
  final String header;
  final String hintText;
  final FocusNode focusNode;
  final IconData icons;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function() onPressed;

  const TextFiledWithButton({
    super.key,
    required this.header,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.icons,
    required this.prefixIcon,
    required this.onPressed,
  });

  @override
  State<TextFiledWithButton> createState() => _TextFiledWithButtonState();
}

class _TextFiledWithButtonState extends State<TextFiledWithButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.header,
          style: const TextStyle(
            fontFamily: 'RussoOne',
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: TextField(
                focusNode: widget.focusNode,
                cursorColor: const Color.fromRGBO(174, 176, 178, 1),
                style: const TextStyle(
                  fontFamily: 'ChakraPetch',
                  fontSize: 15,
                  color: Color.fromRGBO(174, 176, 178, 1),
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 15,
                    color: Color.fromRGBO(174, 176, 178, 1),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10),
                  fillColor: Colors.red,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(174, 176, 178, 1),
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    color: widget.focusNode.hasPrimaryFocus
                        ? Colors.blue
                        : const Color.fromRGBO(174, 176, 178, 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
                controller: widget.controller,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(32, 35, 41, 1),
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: widget.onPressed,
                  icon: Icon(
                    widget.icons,
                    color: const Color.fromRGBO(174, 176, 178, 1),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
