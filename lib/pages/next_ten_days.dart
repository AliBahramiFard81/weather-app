import 'package:flutter/material.dart';
import 'package:main/models/next_five_days.dart';
import 'package:intl/intl.dart';

import '../models/get_weather_icon.dart';

class NextTenDaysForecast extends StatefulWidget {
  final List<NextDaysForecast> nextDaysForecast;
  const NextTenDaysForecast({super.key, required this.nextDaysForecast});

  @override
  State<NextTenDaysForecast> createState() => _NextTenDaysForecastState();
}

class _NextTenDaysForecastState extends State<NextTenDaysForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.nextDaysForecast.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: Text(
              DateFormat('E')
                  .format(DateTime.parse(widget.nextDaysForecast[index].date)),
              style: const TextStyle(
                fontFamily: 'ChakraPetch',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              DateFormat('dd MMMM,yyyy')
                  .format(DateTime.parse(widget.nextDaysForecast[index].date)),
              style: const TextStyle(
                fontFamily: 'ChakraPetch',
                fontSize: 12,
                color: Color.fromRGBO(174, 176, 178, 1),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            trailing: Image.asset(
              GetIcon(
                      condition:
                          widget.nextDaysForecast[index].iconPhrase.iconPhrase)
                  .icon(),
              width: 40,
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${widget.nextDaysForecast[index].temperature.minimum}°c',
                  style: const TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 15,
                    color: Color.fromRGBO(174, 176, 178, 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 65,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.orangeAccent,
                          Colors.red,
                          Colors.redAccent
                          //add more colors for gradient
                        ],
                      )),
                ),
                Text(
                  '${widget.nextDaysForecast[index].temperature.maximum}°c',
                  style: const TextStyle(
                    fontFamily: 'ChakraPetch',
                    fontSize: 15,
                    color: Colors.white,
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
