import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final currentForecast = state.forecastObject?.current;
        if (currentForecast == null) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Humidity: ${currentForecast.humidity ?? 0}%',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Text(
                  'Feels Like: ${currentForecast.feelslikeC ?? 0}°C',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
