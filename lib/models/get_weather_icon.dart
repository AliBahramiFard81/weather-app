class GetIcon {
  final String condition;
  GetIcon({required this.condition});

  String icon() {
    String icon = '';
    switch (condition) {
      case "T-Storms":
        icon = "lib/assets/images/thunder.png";
        break;
      case "Clear":
        icon = "lib/assets/images/moon.png";
        break;
      case "Sunny":
        icon = "lib/assets/images/sunny.png";
        break;
      case "Mostly cloudy":
        icon = "lib/assets/images/mostly_cloudy.png";
        break;
      case "Mostly sunny":
        icon = "lib/assets/images/mostly_sunny.png";
        break;
      case "Partly sunny":
        icon = "lib/assets/images/mostly_sunny.png";
        break;
      case "Intermittent clouds":
        icon = "lib/assets/images/mostly_sunny.png";
        break;
      case "Hazy Sunshine":
        icon = "lib/assets/images/fog.png";
        break;
      case "Cloudy":
        icon = "lib/assets/images/cloud.png";
        break;
      case "Dreary":
        icon = "lib/assets/images/cloud.png";
        break;
      case "Fog":
        icon = "lib/assets/images/fog.png";
        break;
      case "Showers":
        icon = "lib/assets/images/rain_cloud.png";
        break;
      case "Mostly Cloudy w/ Showers":
        icon = "lib/assets/images/sunny_rain.png";
        break;
      case "Partly Sunny w/ Showers":
        icon = "lib/assets/images/sunny_rain.png";
        break;
      default:
        icon = "lib/assets/images/default.png";
    }
    return icon;
  }
}
