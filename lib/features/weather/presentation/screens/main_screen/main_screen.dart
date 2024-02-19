import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathet_app/di/di.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';
import 'package:weathet_app/features/weather/presentation/widgets/city_info_widget.dart';
import 'package:weathet_app/features/weather/presentation/widgets/hourly_forecast_widget.dart';
import 'package:weathet_app/features/weather/presentation/widgets/search_widget.dart';
import 'package:weathet_app/features/weather/presentation/widgets/temperature_widget.dart';
import 'package:weathet_app/features/weather/presentation/widgets/weather_details_widget.dart';
import 'package:weathet_app/utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getIt<WeatherCubit>().onSubmitLocate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherDataError) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is WeatherCubitLoading) {
            return const Center(
              child: SpinKitCubeGrid(color: Colors.blue, size: 80),
            );
          }
          return const ViewWidget();
        },
      ),
    );
  }
}

class ViewWidget extends StatelessWidget {
  const ViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SearchWidget(),
                SizedBox(height: 70),
                CityInfoWidget(),
                SizedBox(height: 15),
                WeatherDetailsWidget(),
                SizedBox(height: 15),
                HourlyForecastWidget(),
                SizedBox(height: 15),
                TemperatureWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
