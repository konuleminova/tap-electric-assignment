import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';
import 'package:weathet_app/utils/constants.dart';
import 'package:weathet_app/utils/helpers.dart';

class CityInfoWidget extends StatelessWidget {
  const CityInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSearchLoading) {
          return const SpinKitCubeGrid(color: Colors.blue, size: 80);
        }
        final String? url = makeUri(state.forecastObject);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            url != null ? Image.network(url, scale: 1.2) : const SizedBox(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appText(
                  size: 30,
                  text: '${state.forecastObject?.location?.name}',
                  isBold: FontWeight.bold,
                  color: primaryColor,
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(
                      (state.forecastObject?.current?.windDegree ?? 0) / 360),
                  child: const Icon(Icons.north, color: primaryColor),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appText(
                  size: 70,
                  text: '${state.forecastObject?.current?.tempC?.round()}°',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
