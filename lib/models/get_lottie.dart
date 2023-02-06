class GetLottie {
  final String condition;
  GetLottie({required this.condition});

  String icon() {
    String icon = '';
    switch (condition) {
      case "T-Storms":
        icon = "lib/assets/lottie/SunAndCloud_b45ffd0c.json";
        break;
      case "Clear":
        icon = "lib/assets/lottie/SunAndCloud_28b711f9.json";
        break;
      case "Sunny":
        icon = "lib/assets/lottie/SunAndCloud_a027d46f.json";
        break;
      case "Mostly cloudy":
        icon = "lib/assets/lottie/SunAndCloud_21d960c9.json";
        break;
      case "Mostly sunny":
        icon = "lib/assets/lottie/SunAndCloud_a1b35e08.json";
        break;
      case "Partly sunny":
        icon = "lib/assets/lottie/SunAndCloud_a1b35e08.json";
        break;
      case "Intermittent clouds":
        icon = "lib/assets/lottie/SunAndCloud_5158efbb.json";
        break;
      case "Hazy Sunshine":
        icon = "lib/assets/lottie/SunAndCloud_000c4e6c.json";
        break;
      case "Cloudy":
        icon = "lib/assets/lottie/SunAndCloud_5158efbb.json";
        break;
      case "Dreary":
        icon = "lib/assets/lottie/SunAndCloud_5158efbb.json";
        break;
      case "Fog":
        icon = "lib/assets/lottie/SunAndCloud_000c4e6c.json";
        break;
      case "Showers":
        icon = "lib/assets/lottie/TheMoomintroll_264ba35c.json";
        break;
      case "Mostly Cloudy w/ Showers":
        icon = "lib/assets/lottie/TheMoomintroll_264ba35c.json";
        break;
      case "Partly Sunny w/ Showers":
        icon = "lib/assets/lottie/TheMoomintroll_264ba35c.json";
        break;
      default:
        icon = "lib/assets/lottie/SunAndCloud_4c32bb34.json";
    }
    return icon;
  }
}
