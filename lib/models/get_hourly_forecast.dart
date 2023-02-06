class HourlyForecast {
  final int epochDateTime;
  final String iconPhrase;
  final HourlyTemperature temperature;
  HourlyForecast({
    required this.epochDateTime,
    required this.iconPhrase,
    required this.temperature,
  });
}

class HourlyTemperature {
  final double value;
  HourlyTemperature({required this.value});
}
