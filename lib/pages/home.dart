import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main/models/daily_forecast.dart';
import 'package:main/models/next_five_days.dart';
import 'package:main/widgets/weather_details.dart';
import '../widgets/home_appbar.dart';
import '../widgets/weather_temperature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/get_city_id.dart';
import '../models/get_date.dart';
import '../models/get_weather_icon.dart';
import '../widgets/circle_indicator.dart';
import '../pages/today_forecast.dart';
import '../pages/tomorrow_forecast.dart';
import '../pages/next_ten_days.dart';
import '../models/get_hourly_forecast.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String? city = '';
  int? key = 0;
  String? apiKey = '';
  late TabController _controller;
  int index = 0;

  @override
  void initState() {
    atStart();
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        index = _controller.index;
      });
    });
  }

  Future atStart() async {
    print('fetching...');
    await readPreferences();
    await getCityId();
    getDailyForecast();
    getLast24HourTemperature();
    getNext12HourTemperature();
    getNext5DaysForecast();
  }

  Future readPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    //await preferences.setString('apiKey', 'mbDjDbhAq4erHJvtFybKZbb5fjyuF1Rs');
    apiKey = preferences.getString('apiKey');
    city = preferences.getString('city');

    if (apiKey == null || city == null) {
      await preferences.setString('apiKey', 'u8bPlHHqoHkCA16xxXtDDzY1tvwDQYiK');
      await preferences.setString('city', 'tehran');
    }

    apiKey = preferences.getString('apiKey');
    city = preferences.getString('city');
  }

  List<CityId> _cityId = [];
  Future getCityId() async {
    String url =
        'http://dataservice.accuweather.com/locations/v1/cities/search?apikey=$apiKey&q=$city';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json as List<dynamic>;
    _cityId = result.map((e) {
      return CityId(
        key: e['Key'],
        city: e['EnglishName'],
      );
    }).toList();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('key', int.parse(_cityId[0].key));
    key = preferences.getInt('key');
    setState(() {});
  }

  List<DailyForecast> _dailyForecast = [];
  void getDailyForecast() async {
    String url =
        'http://dataservice.accuweather.com/currentconditions/v1/$key?apikey=$apiKey&details=true';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final dailyForecast = json as List<dynamic>;
    _dailyForecast = dailyForecast.map((e) {
      final temperature = Temperature(
        metric: e['Temperature']['Metric']['Value'],
        imperia: e['Temperature']['Imperial']['Value'],
      );

      final wind = Wind(speed: e['Wind']['Speed']['Metric']['Value']);
      return DailyForecast(
        temperature: temperature,
        humidity: e['RelativeHumidity'],
        weatherCondition: e['WeatherText'],
        wind: wind,
      );
    }).toList();
    setState(() {});
  }

  List<HourlyForecast> _last24Hours = [];
  void getLast24HourTemperature() async {
    String url =
        'http://dataservice.accuweather.com/currentconditions/v1/$key/historical/24?apikey=$apiKey&metric=true';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json as List<dynamic>;
    _last24Hours = result.map((e) {
      final hourlyTemperature =
          HourlyTemperature(value: e['Temperature']['Metric']['Value']);

      return HourlyForecast(
        epochDateTime: e['EpochTime'],
        iconPhrase: e['WeatherText'],
        temperature: hourlyTemperature,
      );
    }).toList();
    setState(() {
      _tabPages[0] = TodayForecast(hourlyForecast: _last24Hours);
    });
  }

  List<HourlyForecast> _next12Hours = [];
  void getNext12HourTemperature() async {
    String url =
        'http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/$key?apikey=$apiKey&metric=true';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json as List<dynamic>;

    _next12Hours = result.map((e) {
      final hourlyTemperature = HourlyTemperature(
        value: e['Temperature']['Value'],
      );
      return HourlyForecast(
        epochDateTime: e['EpochDateTime'],
        iconPhrase: e['IconPhrase'],
        temperature: hourlyTemperature,
      );
    }).toList();

    setState(() {
      _tabPages[1] = TomorrowForecast(hourlyForecast: _next12Hours);
    });
  }

  List<NextDaysForecast> _next5Days = [];
  void getNext5DaysForecast() async {
    String url =
        'http://dataservice.accuweather.com/forecasts/v1/daily/5day/$key?apikey=$apiKey&metric=true';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['DailyForecasts'] as List<dynamic>;

    _next5Days = result.map((e) {
      final temperature = NextDaysTemperature(
        maximum: e['Temperature']['Maximum']['Value'],
        minimum: e['Temperature']['Minimum']['Value'],
      );

      final iconPhrase = IconPhrase(iconPhrase: e['Day']['IconPhrase']);
      return NextDaysForecast(
        date: e['Date'],
        epochDate: e['EpochDate'],
        temperature: temperature,
        iconPhrase: iconPhrase,
      );
    }).toList();
    setState(() {
      _tabPages[2] = NextTenDaysForecast(nextDaysForecast: _next5Days);
    });
  }

  DateTime date = DateTime.now();
  final List<Widget> _tabPages = [
    TodayForecast(
      hourlyForecast: List<HourlyForecast>.generate(1, (index) {
        return HourlyForecast(
          epochDateTime: 111,
          iconPhrase: "iconPhrase",
          temperature: HourlyTemperature(value: 1),
        );
      }),
    ),
    TomorrowForecast(
      hourlyForecast: List<HourlyForecast>.generate(1, (index) {
        return HourlyForecast(
          epochDateTime: 111,
          iconPhrase: "iconPhrase",
          temperature: HourlyTemperature(value: 1),
        );
      }),
    ),
    NextTenDaysForecast(
      nextDaysForecast: List<NextDaysForecast>.generate(1, (index) {
        return NextDaysForecast(
          date: '2023-02-07T07:00:00+03:30',
          iconPhrase: IconPhrase(iconPhrase: "Sunny"),
          temperature: NextDaysTemperature(maximum: 1, minimum: 1),
          epochDate: 111,
        );
      }),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = height - padding.top - padding.bottom;
    // Height (without status bar)
    double height2 = height - padding.top;

// Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(26, 28, 30, 1),
        appBar: HomePageAppBar(
          location: _cityId.isNotEmpty ? _cityId[0].city : 'Loading',
          date: GetDate(day: date.day, month: date.month, weekDay: date.weekday)
              .date(),
          refresh: atStart,
        ),
        body: CustomRefreshIndicator(
          builder: MaterialIndicatorDelegate(
            builder: (context, controller) {
              return const Icon(
                Icons.refresh,
                color: Colors.blue,
                size: 30,
              );
            },
          ),
          onRefresh: atStart,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              children: [
                SizedBox(
                  height: height3 - 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WeatherTemperature(
                        temperature: _dailyForecast.isNotEmpty
                            ? double.parse(_dailyForecast[0]
                                .temperature
                                .metric
                                .toStringAsFixed(1))
                            : 0,
                        weatherCondition: _dailyForecast.isNotEmpty
                            ? _dailyForecast[0].weatherCondition
                            : 'Loading',
                        image: _dailyForecast.isNotEmpty
                            ? GetIcon(
                                    condition:
                                        _dailyForecast[0].weatherCondition)
                                .icon()
                            : 'lib/assets/images/thunder.png',
                      ),
                      WeatherDetails(
                        windSpeed: _dailyForecast.isNotEmpty
                            ? _dailyForecast[0].wind.speed
                            : 0,
                        humidity: _dailyForecast.isNotEmpty
                            ? _dailyForecast[0].humidity
                            : 0,
                        rain: 100,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: TabBar(
                          controller: _controller,
                          labelColor: Colors.white,
                          unselectedLabelColor:
                              const Color.fromRGBO(174, 176, 178, 1),
                          isScrollable: true,
                          labelStyle: const TextStyle(
                            fontFamily: 'ChakraPetch',
                            fontSize: 15,
                          ),
                          indicator: CircleTabIndicator(
                              color: Colors.white, radius: 3),
                          tabs: const [
                            Tab(text: "Last 24h"),
                            Tab(text: "Next 12h"),
                            Tab(text: "Next 5 days"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: index,
                          children: _tabPages,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
