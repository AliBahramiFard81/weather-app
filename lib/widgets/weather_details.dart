import 'package:flutter/material.dart';

class WeatherDetails extends StatefulWidget {
  final double windSpeed;
  final int humidity;
  final int rain;
  const WeatherDetails({
    super.key,
    required this.windSpeed,
    required this.humidity,
    required this.rain,
  });

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  final TextStyle _conditionStyle = const TextStyle(
    fontFamily: 'ChakraPetch',
    color: Color.fromRGBO(174, 176, 178, 1),
    fontSize: 14,
  );

  final TextStyle _dataStyle = const TextStyle(
    fontFamily: 'ChakraPetch',
    color: Colors.white,
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(32, 35, 41, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(32, 35, 41, 1),
            blurRadius: 2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'lib/assets/images/dash.png',
                  height: 25,
                ),
                Text(
                  '${widget.windSpeed} km/h',
                  style: _dataStyle,
                ),
                Text(
                  'Wind',
                  style: _conditionStyle,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'lib/assets/images/drops.png',
                  height: 25,
                ),
                Text(
                  '${widget.humidity}%',
                  style: _dataStyle,
                ),
                Text(
                  'Humidity',
                  style: _conditionStyle,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'lib/assets/images/umbrella_with_rain_drops.png',
                  height: 25,
                ),
                Text(
                  '${widget.rain}%',
                  style: _dataStyle,
                ),
                Text(
                  'Rain',
                  style: _conditionStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
