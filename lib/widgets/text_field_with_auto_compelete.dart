import 'dart:convert';
import '../models/get_cities.dart';
import 'package:flutter/material.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TextFieldWithAutoComplete extends StatefulWidget {
  final String header;
  final String hintText;
  final FocusNode focusNode;
  final IconData icons;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function() onPressed;

  const TextFieldWithAutoComplete({
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
  State<TextFieldWithAutoComplete> createState() =>
      _TextFieldWithAutoCompleteState();
}

class _TextFieldWithAutoCompleteState extends State<TextFieldWithAutoComplete> {
  String? apiKey = '';

  Future readPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    //await preferences.setString('apiKey', 'hYlj2VcvvX5BIzIv9oJuYn0nzhLipxRb');
    apiKey = preferences.getString('apiKey');
  }

  List<CityName> _cityName = [];
  final List<String> _cities = [];
  Future getSuggestions(String text) async {
    _cities.clear();
    String url =
        'http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=$apiKey&q=${widget.controller.text.toLowerCase()}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json as List<dynamic>;
    _cityName = result.map((e) {
      return CityName(localizedName: e['LocalizedName']);
    }).toList();

    for (var e in _cityName) {
      _cities.add(e.localizedName);
      print(e.localizedName);
    }
  }

  @override
  void initState() {
    readPreferences();
    super.initState();
  }

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
              child: EasyAutocomplete(
                suggestions: _cities,
                focusNode: widget.focusNode,
                cursorColor: const Color.fromRGBO(174, 176, 178, 1),
                inputTextStyle: const TextStyle(
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
                onChanged: (p0) {
                  if (widget.controller.text.isNotEmpty) {
                    getSuggestions(p0);
                    setState(() {});
                  } else {
                    //print("empty");
                  }
                },
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
