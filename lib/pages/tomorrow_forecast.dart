import 'package:flutter/material.dart';
import 'package:main/models/get_weather_icon.dart';

import '../models/get_hourly_forecast.dart';

class TomorrowForecast extends StatefulWidget {
  final List<HourlyForecast> hourlyForecast;
  const TomorrowForecast({
    super.key,
    required this.hourlyForecast,
  });

  @override
  State<TomorrowForecast> createState() => _TomorrowForecastState();
}

class _TomorrowForecastState extends State<TomorrowForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.hourlyForecast.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: Text(
              '${DateTime.fromMillisecondsSinceEpoch(widget.hourlyForecast[index].epochDateTime * 1000).hour}',
              style: const TextStyle(
                fontFamily: 'ChakraPetch',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            trailing: Image.asset(
              GetIcon(condition: widget.hourlyForecast[index].iconPhrase)
                  .icon(),
              width: 30,
            ),
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.hourlyForecast[index].iconPhrase,
                    style: const TextStyle(
                      fontFamily: 'ChakraPetch',
                      fontSize: 15,
                      color: Color.fromRGBO(174, 176, 178, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${widget.hourlyForecast[index].temperature.value}°c',
                    style: const TextStyle(
                      fontFamily: 'ChakraPetch',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
