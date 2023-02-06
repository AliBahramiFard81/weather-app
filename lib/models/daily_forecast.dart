class DailyForecast {
  final Temperature temperature;
  final int humidity;
  final String weatherCondition;
  final Wind wind;
  DailyForecast({
    required this.temperature,
    required this.humidity,
    required this.weatherCondition,
    required this.wind,
  });
}

class Temperature {
  final double metric;
  final double imperia;
  Temperature({
    required this.metric,
    required this.imperia,
  });
}

class Wind {
  final double speed;
  Wind({required this.speed});
}
