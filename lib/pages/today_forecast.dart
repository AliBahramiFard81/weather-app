import 'package:flutter/material.dart';
import 'package:main/models/get_lottie.dart';
import '../models/get_hourly_forecast.dart';
import '../widgets/hourly_forecast.dart';
import 'package:lottie/lottie.dart';

class TodayForecast extends StatefulWidget {
  final List<HourlyForecast> hourlyForecast;
  const TodayForecast({super.key, required this.hourlyForecast});

  @override
  State<TodayForecast> createState() => _TodayForecastState();
}

class _TodayForecastState extends State<TodayForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.hourlyForecast.length,
              itemBuilder: (BuildContext context, index) {
                return HourlyForecastContainer(
                  hourlyForecast: widget.hourlyForecast,
                  index: index,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Center(
                child: Lottie.asset(
                    GetLottie(condition: widget.hourlyForecast[0].iconPhrase)
                        .icon()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
