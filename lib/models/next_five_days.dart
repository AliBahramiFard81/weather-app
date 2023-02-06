class NextDaysForecast {
  final String date;
  final int epochDate;
  final NextDaysTemperature temperature;
  final IconPhrase iconPhrase;
  NextDaysForecast({
    required this.date,
    required this.epochDate,
    required this.temperature,
    required this.iconPhrase,
  });
}

class NextDaysTemperature {
  final double maximum;
  final double minimum;
  NextDaysTemperature({
    required this.maximum,
    required this.minimum,
  });
}

class IconPhrase {
  final String iconPhrase;
  IconPhrase({required this.iconPhrase});
}
