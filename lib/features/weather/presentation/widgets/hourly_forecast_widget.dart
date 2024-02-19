import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathet_app/features/weather/domain/models/weather_forecast_hourly.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final List<Hour>? hourlyForecast =
            state.forecastObject?.forecast?.forecastday?.first.hour;
        return hourlyForecast != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                    child: Text(
                      'Forecast for today',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hourlyForecast.length,
                      itemBuilder: (context, index) {
                        final Hour hour = hourlyForecast[index];
                        return HourlyForecastItem(hour: hour);
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final Hour hour;

  const HourlyForecastItem({Key? key, required this.hour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String iconUrl = 'https:${hour.condition?.icon}';
    final String hourValue = hour.time?.split(' ')[1] ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hourValue,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Image.network(iconUrl),
          Text(
            '${hour.tempC}°C',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
