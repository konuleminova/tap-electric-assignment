import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathet_app/features/weather/domain/temperature.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';

class TemperatureWidget extends StatefulWidget {
  const TemperatureWidget({Key? key}) : super(key: key);

  @override
  _TemperatureWidgetState createState() => _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  late String selectedUnit;
  late num convertedTemperature;

  @override
  void initState() {
    super.initState();
    selectedUnit = 'C';
    convertedTemperature = 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<TemperatureUnit> temperatureUnits = [
      TemperatureUnit('Celsius', 'C'),
      TemperatureUnit('Fahrenheit', 'F'),
      TemperatureUnit('Kelvin', 'K'),
    ];

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSearchLoading) {
          return const SpinKitCubeGrid(color: Colors.blue, size: 80);
        }

        final currentTemperature = state.forecastObject?.current?.tempC ?? 0;
        convertedTemperature = Temperature.convert(
          currentTemperature,
          'C',
          selectedUnit,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Select Unit:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  TemperatureUnitDropdown(
                    temperatureUnits: temperatureUnits,
                    onChanged: (unit) {
                      setState(() {
                        selectedUnit = unit ?? 'C';
                        convertedTemperature = Temperature.convert(
                          currentTemperature,
                          'C',
                          selectedUnit,
                        );
                      });
                    },
                    selectedUnit: selectedUnit,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Converted Temperature: $convertedTemperature $selectedUnit',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TemperatureUnit {
  final String name;
  final String abbreviation;

  TemperatureUnit(this.name, this.abbreviation);
}

class TemperatureUnitDropdown extends StatelessWidget {
  final List<TemperatureUnit> temperatureUnits;
  final ValueChanged<String?> onChanged;
  final String selectedUnit;

  const TemperatureUnitDropdown({
    Key? key,
    required this.temperatureUnits,
    required this.onChanged,
    required this.selectedUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedUnit,
      onChanged: onChanged,
      items: temperatureUnits
          .map<DropdownMenuItem<String>>((TemperatureUnit unit) {
        return DropdownMenuItem<String>(
          value: unit.abbreviation,
          child: Text(unit.name),
        );
      }).toList(),
    );
  }
}
