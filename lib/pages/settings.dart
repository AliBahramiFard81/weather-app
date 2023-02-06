// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../widgets/settings_appbar.dart';
import '../widgets/text_filed_with_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../widgets/text_field_with_auto_compelete.dart';

class Settings extends MaterialPageRoute<bool> {
  Settings()
      : super(builder: (BuildContext context) {
          return const SettingsPage();
        });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final List<TextEditingController> _controller = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> _focusNode = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    atStart();
    super.initState();

    // ignore: avoid_function_literals_in_foreach_calls
    _focusNode.forEach((element) {
      element.addListener(() {
        setState(() {});
      });
    });
    // ignore: avoid_function_literals_in_foreach_calls
    _controller.forEach((element) {
      element = TextEditingController();
    });
  }

  @override
  void dispose() {
    // ignore: avoid_function_literals_in_foreach_calls
    _controller.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void atStart() async {
    await readPreferences();
  }

  Future readPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    String? apikey = preferences.getString('apiKey');
    String? city = preferences.getString('city');
    _controller[0].text = apikey.toString();
    _controller[1].text = city.toString();
  }

  void updateApiKey() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("apiKey", _controller[0].text.toString());

    _focusNode[0].unfocus();

    AnimatedSnackBar.material(
      "Updated API Key Successfully",
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  void updateCity() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("city", _controller[1].text.toString());

    _focusNode[1].unfocus();

    AnimatedSnackBar.material(
      "Updated City Successfully",
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 28, 30, 1),
      appBar: SettingsAppBar(
        context: context,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFiledWithButton(
              onPressed: updateApiKey,
              header: "API key",
              controller: _controller[0],
              focusNode: _focusNode[0],
              hintText: "API Key",
              icons: Icons.check,
              prefixIcon: Icons.key,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithAutoComplete(
              onPressed: updateCity,
              header: "City",
              controller: _controller[1],
              focusNode: _focusNode[1],
              hintText: "City",
              icons: Icons.check,
              prefixIcon: Icons.location_city,
            ),
          ],
        ),
      ),
    );
  }
}
