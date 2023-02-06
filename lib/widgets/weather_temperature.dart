import 'package:flutter/material.dart';

class WeatherTemperature extends StatefulWidget {
  final double temperature;
  final String weatherCondition;
  final String image;
  const WeatherTemperature({
    super.key,
    required this.temperature,
    required this.weatherCondition,
    required this.image,
  });

  @override
  State<WeatherTemperature> createState() => _WeatherTemperatureState();
}

class _WeatherTemperatureState extends State<WeatherTemperature> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.temperature}°c',
                    style: const TextStyle(
                      fontFamily: 'RussoOne',
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  Text(
                    widget.weatherCondition,
                    style: const TextStyle(
                      fontFamily: 'ChakraPetch',
                      color: Color.fromRGBO(174, 176, 178, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              widget.image,
              filterQuality: FilterQuality.high,
              height: 100,
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
    );
  }
}
