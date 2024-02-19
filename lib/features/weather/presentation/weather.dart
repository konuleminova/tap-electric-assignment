library weather;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weathet_app/features/weather/domain/models/weather_forecast_hourly.dart';
import 'package:weathet_app/features/weather/data/repositories//weather_repository.dart';
import 'package:weathet_app/features/weather/domain/repositories/weather_repository.dart';

part 'weather_cubit.dart';

part 'weather_state.dart';
