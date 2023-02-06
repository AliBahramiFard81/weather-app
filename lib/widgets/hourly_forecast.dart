import 'package:flutter/material.dart';
import 'package:main/models/get_hourly_forecast.dart';
import 'package:main/models/get_weather_icon.dart';

class HourlyForecastContainer extends StatefulWidget {
  final List<HourlyForecast> hourlyForecast;
  final int index;
  const HourlyForecastContainer({
    super.key,
    required this.hourlyForecast,
    required this.index,
  });

  @override
  State<HourlyForecastContainer> createState() =>
      _HourlyForecastContainerState();
}

class _HourlyForecastContainerState extends State<HourlyForecastContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(32, 35, 41, 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(32, 35, 41, 1),
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${DateTime.fromMillisecondsSinceEpoch(widget.hourlyForecast[widget.index].epochDateTime * 1000).hour}",
            style: const TextStyle(
              fontFamily: 'ChakraPetch',
              color: Color.fromRGBO(174, 176, 178, 1),
              fontSize: 14,
            ),
          ),
          Image.asset(
            GetIcon(condition: widget.hourlyForecast[widget.index].iconPhrase)
                .icon(),
            height: 40,
          ),
          Text(
            "${widget.hourlyForecast[widget.index].temperature.value}°c",
            style: const TextStyle(
              fontFamily: 'ChakraPetch',
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
